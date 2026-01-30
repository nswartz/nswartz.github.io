# Resume Viewer Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add a resume PDF viewer modal accessible from the header, with download functionality and Font Awesome cleanup.

**Architecture:** Modal overlay triggered by header icon, PDF displayed via iframe, vanilla JS for open/close behavior. Clean up unused local font files since FA and Devicon load via CDN.

**Tech Stack:** Jekyll, SCSS, vanilla JavaScript, Font Awesome 6 (CDN)

---

## Task 1: Fix Font Awesome CDN and Update Icon Classes

**Files:**
- Modify: `.worktrees/feature-resume-viewer/_includes/head.html:11`
- Modify: `.worktrees/feature-resume-viewer/_includes/header.html:8-15`
- Modify: `.worktrees/feature-resume-viewer/_includes/about.html:34,39`

**Step 1: Update Font Awesome CDN version in head.html**

Change line 11 from:
```html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
```

To:
```html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
```

**Step 2: Update header.html icon classes to FA 6 syntax**

Change line 8 from:
```html
<a aria-label="Send email" href="mailto:{{site.email}}"><i class="icon fa fa-envelope" aria-hidden="true"></i></a>
```

To:
```html
<a aria-label="Send email" href="mailto:{{site.email}}"><i class="icon fa-solid fa-envelope" aria-hidden="true"></i></a>
```

Change line 9 from:
```html
<a aria-label="My Github" target="_blank" rel="noopener" href="https://github.com/{{site.github_username}}"><i class="icon fa fa-github-alt" aria-hidden="true"></i></a>
```

To:
```html
<a aria-label="My Github" target="_blank" rel="noopener" href="https://github.com/{{site.github_username}}"><i class="icon fa-brands fa-github-alt" aria-hidden="true"></i></a>
```

Change line 15 from:
```html
<a class="down" href="#about" data-scroll><i class="icon fa fa-chevron-down" aria-hidden="true"></i></a>
```

To:
```html
<a class="down" href="#about" data-scroll><i class="icon fa-solid fa-chevron-down" aria-hidden="true"></i></a>
```

**Step 3: Update about.html icon classes to FA 6 syntax**

Change line 34 from:
```html
<i class="fa fa-star" style="font-size: 80px;" aria-hidden="true"></i>
```

To:
```html
<i class="fa-solid fa-star" style="font-size: 80px;" aria-hidden="true"></i>
```

Change line 39 from:
```html
<i class="fa fa-music" style="font-size: 80px;" aria-hidden="true"></i>
```

To:
```html
<i class="fa-solid fa-music" style="font-size: 80px;" aria-hidden="true"></i>
```

**Step 4: Verify icons render correctly**

Run: `npm run dev` (if not already running)
Open: http://localhost:4000
Expected: All icons (envelope, GitHub, chevron, star, music) render correctly

**Step 5: Commit**

```bash
git add _includes/head.html _includes/header.html _includes/about.html
git commit -m "fix: update Font Awesome to v6.5.1 and migrate icon classes"
```

---

## Task 2: Add Resume Icon to Header

**Files:**
- Modify: `.worktrees/feature-resume-viewer/_includes/header.html:8-10`

**Step 1: Add resume icon link between email and GitHub**

Change the header-icons div content from:
```html
<div class="header-icons">
  <a aria-label="Send email" href="mailto:{{site.email}}"><i class="icon fa-solid fa-envelope" aria-hidden="true"></i></a>
  <a aria-label="My Github" target="_blank" rel="noopener" href="https://github.com/{{site.github_username}}"><i class="icon fa-brands fa-github-alt" aria-hidden="true"></i></a>
</div>
```

To:
```html
<div class="header-icons">
  <a aria-label="Send email" href="mailto:{{site.email}}"><i class="icon fa-solid fa-envelope" aria-hidden="true"></i></a>
  <a aria-label="View Resume" href="#" id="resume-link"><i class="icon fa-regular fa-file-lines" aria-hidden="true"></i></a>
  <a aria-label="My Github" target="_blank" rel="noopener" href="https://github.com/{{site.github_username}}"><i class="icon fa-brands fa-github-alt" aria-hidden="true"></i></a>
</div>
```

**Step 2: Verify icon appears**

Refresh: http://localhost:4000
Expected: Resume icon (document) appears between email and GitHub icons

**Step 3: Commit**

```bash
git add _includes/header.html
git commit -m "feat: add resume icon to header"
```

---

## Task 3: Create Modal Styles

**Files:**
- Create: `.worktrees/feature-resume-viewer/src/styles/_resume-modal.scss`
- Modify: `.worktrees/feature-resume-viewer/src/styles/main.scss`

**Step 1: Create the resume modal SCSS file**

Create `src/styles/_resume-modal.scss` with:
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

**Step 2: Import the new styles in main.scss**

Add to end of `src/styles/main.scss`:
```scss
@import 'resume-modal';
```

**Step 3: Verify SCSS compiles**

Check dev server output or refresh http://localhost:4000
Expected: No SCSS compilation errors

**Step 4: Commit**

```bash
git add src/styles/_resume-modal.scss src/styles/main.scss
git commit -m "feat: add resume modal styles"
```

---

## Task 4: Add Modal HTML to Layout

**Files:**
- Modify: `.worktrees/feature-resume-viewer/_layouts/default.html`

**Step 1: Add modal HTML before closing body tag**

Change the end of `_layouts/default.html` from:
```html
      {% include footer.html %}
  </body>
```

To:
```html
      {% include footer.html %}

      <!-- Resume Modal -->
      <div id="resume-modal" class="resume-modal" hidden>
        <div class="resume-modal-backdrop"></div>
        <div class="resume-modal-container">
          <div class="resume-modal-header">
            <span>Resume</span>
            <div class="resume-modal-actions">
              <a href="{{ "/assets/Resume-2025.pdf" | prepend: site.baseurl }}" download aria-label="Download Resume">
                <i class="fa-solid fa-download"></i>
              </a>
              <button class="resume-close-btn" aria-label="Close">
                <i class="fa-solid fa-xmark"></i>
              </button>
            </div>
          </div>
          <div class="resume-modal-body">
            <iframe src="{{ "/assets/Resume-2025.pdf" | prepend: site.baseurl }}" title="Resume"></iframe>
          </div>
        </div>
      </div>
  </body>
```

**Step 2: Verify modal HTML is in page**

Refresh: http://localhost:4000
Open DevTools, search for "resume-modal"
Expected: Modal div exists in DOM (hidden)

**Step 3: Commit**

```bash
git add _layouts/default.html
git commit -m "feat: add resume modal HTML to layout"
```

---

## Task 5: Add Modal JavaScript

**Files:**
- Modify: `.worktrees/feature-resume-viewer/src/js/app.js`

**Step 1: Add modal logic to app.js**

Add the following after line 117 (after the closing `});` of DOMContentLoaded):

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
  if (e.key === 'Escape' && resumeModal && !resumeModal.hidden) {
    closeResumeModal();
  }
});
```

**Step 2: Test modal functionality**

Refresh: http://localhost:4000
Click resume icon in header
Expected: Modal opens with PDF visible
Click X button
Expected: Modal closes
Click resume icon again, then press Escape
Expected: Modal closes
Click resume icon again, then click dark backdrop
Expected: Modal closes

**Step 3: Test download button**

Open modal, click download icon
Expected: PDF downloads

**Step 4: Commit**

```bash
git add src/js/app.js
git commit -m "feat: add resume modal open/close logic"
```

---

## Task 6: Delete Unused Font Files

**Files:**
- Delete: `.worktrees/feature-resume-viewer/src/styles/lib/_fontawesome.scss`
- Delete: `.worktrees/feature-resume-viewer/src/styles/lib/_devicon.scss`
- Delete: `.worktrees/feature-resume-viewer/src/fonts/devicon.ttf`
- Delete: `.worktrees/feature-resume-viewer/src/fonts/devicon.woff`
- Delete: `.worktrees/feature-resume-viewer/src/fonts/fontawesome-webfont.ttf`
- Delete: `.worktrees/feature-resume-viewer/src/fonts/fontawesome-webfont.woff`
- Delete: `.worktrees/feature-resume-viewer/src/fonts/fontawesome-webfont.woff2`
- Delete: `.worktrees/feature-resume-viewer/assets/fonts/devicon.ttf`
- Delete: `.worktrees/feature-resume-viewer/assets/fonts/devicon.woff`
- Delete: `.worktrees/feature-resume-viewer/assets/fonts/fontawesome-webfont.ttf`
- Delete: `.worktrees/feature-resume-viewer/assets/fonts/fontawesome-webfont.woff`
- Delete: `.worktrees/feature-resume-viewer/assets/fonts/fontawesome-webfont.woff2`

**Step 1: Delete unused SCSS lib files**

```bash
rm src/styles/lib/_fontawesome.scss
rm src/styles/lib/_devicon.scss
```

**Step 2: Delete unused src font files**

```bash
rm src/fonts/devicon.ttf src/fonts/devicon.woff
rm src/fonts/fontawesome-webfont.ttf src/fonts/fontawesome-webfont.woff src/fonts/fontawesome-webfont.woff2
```

**Step 3: Delete unused assets font files**

```bash
rm assets/fonts/devicon.ttf assets/fonts/devicon.woff
rm assets/fonts/fontawesome-webfont.ttf assets/fonts/fontawesome-webfont.woff assets/fonts/fontawesome-webfont.woff2
```

**Step 4: Verify site still works**

Refresh: http://localhost:4000
Expected: All icons still render (loaded from CDN)
Expected: Resume modal still works

**Step 5: Commit**

```bash
git add -A
git commit -m "chore: remove unused local font files (FA and Devicon loaded via CDN)"
```

---

## Task 7: Final Verification

**Step 1: Full functionality test**

- [ ] All header icons render (envelope, resume, GitHub)
- [ ] All about section icons render (star, music)
- [ ] Chevron down icon renders
- [ ] Devicon tech icons render (TypeScript, React, etc.)
- [ ] Click resume icon opens modal
- [ ] PDF displays in modal
- [ ] Download button downloads PDF
- [ ] X button closes modal
- [ ] Backdrop click closes modal
- [ ] Escape key closes modal
- [ ] Body scroll is locked when modal open
- [ ] Mobile view shows modal without iframe

**Step 2: If all tests pass, feature is complete**

Ready for PR or merge via superpowers:finishing-a-development-branch skill.
