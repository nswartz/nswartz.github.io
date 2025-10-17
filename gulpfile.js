const { src, dest, watch, series, parallel } = require('gulp');
const sass = require('sass');
const gulpSass = require('gulp-sass')(sass);
const csso = require('gulp-csso');
const uglify = require('gulp-uglify');
const concat = require('gulp-concat');
const plumber = require('gulp-plumber');
const imagemin = require('gulp-imagemin');
const browserSync = require('browser-sync').create();
const spawn = require('cross-spawn');

// Paths
const paths = {
  styles: 'src/styles/**/*.scss',
  js: 'src/js/**/*.js',
  fonts: 'src/fonts/**/*.{ttf,woff,woff2}',
  images: 'src/img/**/*.{jpg,png,gif}',
  html: ['*.html', '_layouts/*.html', '_includes/*.html', '_posts/**/*.md', '_config.yml']
};

// --- Jekyll build task ---
function jekyllBuild(done) {
  const jekyll = spawn('bundle', ['exec', 'jekyll', 'build'], { stdio: 'inherit', shell: true });
  jekyll.on('close', done);
}

// --- Reload BrowserSync ---
function reload(done) {
  browserSync.reload();
  done();
}

// --- Compile Sass with instant injection ---
function styles() {
  return src(paths.styles)
    .pipe(plumber())
    .pipe(gulpSass())
    .pipe(csso())
    .pipe(dest('assets/css/'))
    .pipe(browserSync.stream()); // Inject CSS without page reload
}

// --- Compile JS with reload ---
function scripts() {
  return src(paths.js)
    .pipe(plumber())
    .pipe(concat('main.js'))
    .pipe(uglify())
    .pipe(dest('assets/js/'))
    .pipe(browserSync.stream());
}

// --- Copy Fonts ---
function fonts() {
  return src(paths.fonts)
    .pipe(plumber())
    .pipe(dest('assets/fonts/'));
}

// --- Optimize Images ---
function images() {
  return src(paths.images)
    .pipe(plumber())
    .pipe(imagemin({ optimizationLevel: 3, progressive: true, interlaced: true }))
    .pipe(dest('assets/img/'));
}

// --- Serve with BrowserSync ---
function serve() {
  browserSync.init({
    server: { baseDir: '_site' },
    port: 4000
  });

  // Watch CSS/JS/images/fonts for instant reload
  watch(paths.styles, styles);
  watch(paths.js, scripts);
  watch(paths.fonts, fonts);
  watch(paths.images, images);

  // Watch Jekyll content for full rebuild
  watch(paths.html, series(jekyllBuild, reload));
}

// --- Default task ---
exports.default = series(
  parallel(styles, scripts, fonts, images),
  jekyllBuild,
  serve
);
