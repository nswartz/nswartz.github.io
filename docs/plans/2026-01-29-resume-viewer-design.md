# Resume Viewer Design

Add the ability to view and download a resume from the portfolio site.

## Overview

A resume icon in the header opens a modal overlay displaying the PDF resume inline. Users can download the PDF via a button in the modal header. Additionally, clean up unused local font files since Font Awesome and Devicon are loaded via CDN.

## Header Icon

Add a resume icon to `header-icons`, positioned between email and GitHub:

```html
<a aria-label="View Resume" href="#" id="resume-link">
  <i class="icon fa-regular fa-file-lines" aria-hidden="true"></i>
</a>
```

Update existing icons to Font Awesome 6 syntax:
- `fa fa-envelope` → `fa-solid fa-envelope`
- `fa fa-github-alt` → `fa-brands fa-github-alt`
- `fa fa-chevron-down` → `fa-solid fa-chevron-down`
- `fa fa-star` → `fa-solid fa-star`
- `fa fa-music` → `fa-solid fa-music`

## Modal Structure

Full-screen overlay with centered PDF viewer:

```html
<div id="resume-modal" class="resume-modal" hidden>
  <div class="resume-modal-backdrop"></div>
  <div class="resume-modal-container">
    <div class="resume-modal-header">
      <span>Resume</span>
      <div class="resume-modal-actions">
        <a href="/assets/Resume-2025.pdf" download aria-label="Download Resume">
          <i class="fa-solid fa-download"></i>
        </a>
        <button class="resume-close-btn" aria-label="Close">
          <i class="fa-solid fa-xmark"></i>
        </button>
      </div>
    </div>
    <div class="resume-modal-body">
      <iframe src="/assets/Resume-2025.pdf" title="Resume"></iframe>
    </div>
  </div>
</div>
```

## Modal Styles

New file: `src/styles/_resume-modal.scss`

```scss
.resume-modal {
  position: fixed;
  inset: 0;
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: center;
}

.resume-modal[hidden] {
  display: none;
}

.resume-modal-backdrop {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.8);
}

.resume-modal-container {
  position: relative;
  width: 90vw;
  max-width: 900px;
  height: 85vh;
  background: #fff;
  border-radius: 8px;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.resume-modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  background: #333;
  color: #fff;
}

.resume-modal-actions {
  display: flex;
  gap: 12px;
}

.resume-modal-actions a,
.resume-modal-actions button {
  background: transparent;
  border: none;
  color: #fff;
  font-size: 1.2rem;
  cursor: pointer;
  opacity: 0.8;
  &:hover { opacity: 1; }
}

.resume-modal-body {
  flex: 1;
  iframe {
    width: 100%;
    height: 100%;
    border: none;
  }
}

// Mobile fallback - iframe PDF viewing is unreliable on small screens
@media (max-width: 600px) {
  .resume-modal-body iframe {
    display: none;
  }
  .resume-modal-container {
    height: auto;
    padding: 2rem;
    text-align: center;
  }
}
```

## JavaScript Behavior

Add to `src/js/app.js`:

```javascript
// Resume Modal
const resumeLink = document.getElementById('resume-link');
const resumeModal = document.getElementById('resume-modal');
const resumeBackdrop = resumeModal?.querySelector('.resume-modal-backdrop');
const resumeCloseBtn = resumeModal?.querySelector('.resume-close-btn');

function openResumeModal(e) {
  e.preventDefault();
  resumeModal.hidden = false;
  document.body.style.overflow = 'hidden';
}

function closeResumeModal() {
  resumeModal.hidden = true;
  document.body.style.overflow = '';
}

resumeLink?.addEventListener('click', openResumeModal);
resumeBackdrop?.addEventListener('click', closeResumeModal);
resumeCloseBtn?.addEventListener('click', closeResumeModal);

document.addEventListener('keydown', (e) => {
  if (e.key === 'Escape' && !resumeModal.hidden) {
    closeResumeModal();
  }
});
```

## Font Awesome CDN Fix

Update `_includes/head.html` to use Font Awesome 6.5.1 (current CDN link references non-existent v7.0.1):

```html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
```

## File Changes

### Create
- `src/styles/_resume-modal.scss`

### Modify
- `_includes/head.html` — fix Font Awesome CDN version
- `_includes/header.html` — add resume icon, update FA 6 class syntax
- `_includes/about.html` — update FA 6 class syntax for icons
- `_layouts/default.html` — add modal HTML before closing `</body>`
- `src/styles/main.scss` — import resume-modal styles
- `src/js/app.js` — add modal logic

### Delete
- `src/styles/lib/_fontawesome.scss`
- `src/styles/lib/_devicon.scss`
- `src/fonts/devicon.ttf`
- `src/fonts/devicon.woff`
- `src/fonts/fontawesome-webfont.ttf`
- `src/fonts/fontawesome-webfont.woff`
- `src/fonts/fontawesome-webfont.woff2`
- `assets/fonts/devicon.ttf`
- `assets/fonts/devicon.woff`
- `assets/fonts/fontawesome-webfont.ttf`
- `assets/fonts/fontawesome-webfont.woff`
- `assets/fonts/fontawesome-webfont.woff2`
