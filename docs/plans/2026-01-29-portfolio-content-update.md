# Portfolio Content Update Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Replace placeholder content with real resume information across the portfolio site.

**Architecture:** Update Jekyll config and HTML includes to display actual professional experience, skills organized as Frontend/Backend/Infrastructure, and personal interests. Hide projects section until ready.

**Tech Stack:** Jekyll, Liquid templates, HTML, devicons, Font Awesome

---

## Task 1: Update Configuration File

**Files:**
- Modify: `_config.yml`

**Step 1: Add user_title field**

Add after line 8 (after `username`):
```yaml
user_title: Full Stack Engineer
```

**Step 2: Add user_description field**

Replace line 9's empty `user_description:` with:
```yaml
user_description: Specializing in TypeScript, React, React Native, .NET, and AWS. Experienced across frontend, backend, mobile, and cloud infrastructure.
```

**Step 3: Add location field**

Add after line 10 (after `email`):
```yaml
location: Elkhorn, NE
```

**Step 4: Verify configuration**

Run: `cat _config.yml | grep -A1 "user_title\|user_description\|location"`

Expected output should show all three new fields with correct values.

**Step 5: Commit configuration changes**

```bash
git add _config.yml
git commit -m "feat: add user profile fields to config

Add user_title, user_description, and location fields.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

---

## Task 2: Update Header Social Links

**Files:**
- Modify: `_includes/header.html`

**Step 1: Update email link**

Find line 8 (the email icon `<a>` tag) and replace:
```html
<a aria-label="Send email" href="#"><i class="icon fa fa-envelope"></i></a>
```

With:
```html
<a aria-label="Send email" href="mailto:{{site.email}}"><i class="icon fa fa-envelope"></i></a>
```

**Step 2: Update GitHub link**

Find line 11 (the GitHub icon `<a>` tag) and replace:
```html
<a aria-label="My Github" target="_blank" href="#"><i class="icon fa fa-github-alt" aria-hidden="true"></i></a>
```

With:
```html
<a aria-label="My Github" target="_blank" href="https://github.com/{{site.github_username}}"><i class="icon fa fa-github-alt" aria-hidden="true"></i></a>
```

**Step 3: Remove Twitter link**

Delete line 9 entirely:
```html
<a aria-label="My Twitter" target="_blank" href="#"><i class="icon fa fa-twitter" aria-hidden="true"></i></a>
```

**Step 4: Remove Google Plus link**

Delete line 10 entirely:
```html
<a aria-label="My Google Plus" target="_blank" href="#"><i class="icon fa fa-google-plus" aria-hidden="true"></i></a>
```

**Step 5: Remove Projects navigation link**

Find line 15 and delete:
```html
<a class="link" href="#projects" data-scroll>Projects</a>
```

**Step 6: Verify changes**

Run: `cat _includes/header.html | grep -c "fa-twitter\|fa-google-plus\|#projects"`

Expected: `0` (all removed)

Run: `cat _includes/header.html | grep -c "mailto:\|github.com"`

Expected: `2` (email and GitHub links present)

**Step 7: Commit header changes**

```bash
git add _includes/header.html
git commit -m "feat: update header with actual social links

- Link email to mailto
- Link GitHub to actual profile
- Remove Twitter and Google Plus
- Remove Projects navigation link

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

---

## Task 3: Update About Section - Frontend Skills

**Files:**
- Modify: `_includes/about.html`

**Step 1: Update first tech section heading**

Replace line 7 (`<h2>Design</h2>`) with:
```html
<h2>Frontend</h2>
```

**Step 2: Update Frontend icons**

Replace lines 8-10 (the three icon lines) with:
```html
<i class="devicon-typescript-plain colored"></i>
<i class="devicon-react-original colored"></i>
<i class="devicon-react-original colored"></i>
```

**Step 3: Update Frontend description**

Replace lines 11-12 (the paragraph) with:
```html
<p>Building responsive web and mobile interfaces with React and React Native. Led TypeScript conversion efforts and established best practices for component design and state management across teams.</p>
```

**Step 4: Verify Frontend section**

Run: `sed -n '6,13p' _includes/about.html`

Expected: Should show Frontend heading, three devicons, and the TypeScript/React description.

**Step 5: Commit Frontend section**

```bash
git add _includes/about.html
git commit -m "feat: update about section with Frontend skills

Replace Design section with actual Frontend technologies.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

---

## Task 4: Update About Section - Backend Skills

**Files:**
- Modify: `_includes/about.html`

**Step 1: Update second tech section heading**

Replace line 15 (`<h2>Code</h2>`) with:
```html
<h2>Backend</h2>
```

**Step 2: Update Backend icons**

Replace lines 16-18 (the three icon lines) with:
```html
<i class="devicon-dotnetcore-plain colored"></i>
<i class="devicon-python-plain colored"></i>
<i class="devicon-nodejs-plain colored"></i>
```

**Step 3: Update Backend description**

Replace lines 19-20 (the paragraph) with:
```html
<p>Developing robust APIs and services with .NET, Python, and Node.js. Collaborated with distributed teams to design backend systems, establish requirements, and lead major version upgrades across codebases.</p>
```

**Step 4: Verify Backend section**

Run: `sed -n '14,21p' _includes/about.html`

Expected: Should show Backend heading, three devicons (.NET, Python, Node), and the backend description.

**Step 5: Commit Backend section**

```bash
git add _includes/about.html
git commit -m "feat: update about section with Backend skills

Replace Code section with actual Backend technologies.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

---

## Task 5: Update About Section - Infrastructure Skills

**Files:**
- Modify: `_includes/about.html`

**Step 1: Update third tech section heading**

Replace line 23 (`<h2>Tools</h2>`) with:
```html
<h2>Infrastructure</h2>
```

**Step 2: Update Infrastructure icons**

Replace lines 24-26 (the three icon lines) with:
```html
<i class="devicon-amazonwebservices-plain-wordmark colored"></i>
<i class="devicon-mongodb-plain colored"></i>
<i class="devicon-jest-plain colored"></i>
```

**Step 3: Update Infrastructure description**

Replace lines 27-28 (the paragraph) with:
```html
<p>Managing cloud infrastructure with AWS (S3, IoT, DocumentDB), working with MongoDB databases, and implementing comprehensive test coverage with Jest, XUnit, and unittest frameworks to ensure system reliability.</p>
```

**Step 4: Verify Infrastructure section**

Run: `sed -n '22,29p' _includes/about.html`

Expected: Should show Infrastructure heading, three devicons (AWS, MongoDB, Jest), and the infrastructure description.

**Step 5: Commit Infrastructure section**

```bash
git add _includes/about.html
git commit -m "feat: update about section with Infrastructure skills

Replace Tools section with actual Infrastructure technologies.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

---

## Task 6: Add Personal Interests Section

**Files:**
- Modify: `_includes/about.html`

**Step 1: Add personal interests section**

After line 30 (after the closing `</div>` of the Infrastructure section, before the final `</div>`), add:

```html
<div class="user-details" style="margin-top: 60px;">
  <h1> When I'm Not Coding </h1>
</div>
<div class="user">
  <div class="tech">
    <h2>Theatre</h2>
    <i class="fa fa-theater-masks" style="font-size: 80px;"></i>
    <p>Major speaking/singing roles in high school and college plays and musicals.</p>
  </div>
  <div class="tech">
    <h2>Choir</h2>
    <i class="fa fa-music" style="font-size: 80px;"></i>
    <p>Member of select vocal ensembles, including a performance at Carnegie Hall.</p>
  </div>
  <div class="tech">
    <!-- Empty third column for visual balance -->
  </div>
</div>
```

**Step 2: Verify the addition**

Run: `tail -20 _includes/about.html`

Expected: Should show the new "When I'm Not Coding" section with Theatre and Choir subsections.

**Step 3: Commit personal interests section**

```bash
git add _includes/about.html
git commit -m "feat: add personal interests section to about

Add Theatre and Choir background below technical skills.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

---

## Task 7: Hide Projects Section

**Files:**
- Modify: `index.html`

**Step 1: Read current index.html**

Run: `cat index.html`

Expected: Should show the layout and includes structure.

**Step 2: Comment out projects include**

Find the line that includes projects (likely `{% include projects.html %}`) and wrap it in Liquid comments:

```liquid
{# {% include projects.html %} #}
```

Or if Jekyll comments are used:
```liquid
<!-- {% include projects.html %} -->
```

**Step 3: Verify projects section is hidden**

Run: `cat index.html | grep -c "include projects"`

Expected: `0` if using Liquid comments, or line should be within HTML comment tags.

**Step 4: Commit projects hiding**

```bash
git add index.html
git commit -m "feat: hide projects section temporarily

Comment out projects include until ready to showcase.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

---

## Task 8: Verify Footer

**Files:**
- Read: `_includes/footer.html`

**Step 1: Check for placeholder content**

Run: `cat _includes/footer.html | grep -i "randecker\|lorem\|placeholder"`

Expected: `0` matches (no placeholder content)

**Step 2: Manual verification**

Run: `cat _includes/footer.html`

Manually verify:
- No references to "Nathan Randecker" or previous authors
- Copyright or credits are generic or removed
- No Google Analytics code that shouldn't be there

**Step 3: If changes needed, make them**

If any issues found, update the file and commit:
```bash
git add _includes/footer.html
git commit -m "feat: clean up footer content

Remove any placeholder references.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

**Step 4: If no changes needed**

No commit necessary - move to final verification.

---

## Task 9: Final Verification

**Files:**
- Read all modified files

**Step 1: Verify all changes are committed**

Run: `git status`

Expected: "working tree clean" or only untracked files

**Step 2: Review commit history**

Run: `git log --oneline -10`

Expected: Should show all commits from this implementation

**Step 3: Verify config values**

Run: `grep -E "user_title|user_description|location" _config.yml`

Expected: All three fields present with correct values

**Step 4: Verify header has correct links**

Run: `grep -E "mailto:|github.com" _includes/header.html`

Expected: Email and GitHub links present, no "#" placeholders

**Step 5: Verify about section structure**

Run: `grep -c "<h2>Frontend</h2>\|<h2>Backend</h2>\|<h2>Infrastructure</h2>" _includes/about.html`

Expected: `3` (all three sections present)

**Step 6: Verify personal interests**

Run: `grep -c "When I'm Not Coding" _includes/about.html`

Expected: `1` (section present)

**Step 7: Verify projects hidden**

Run: `cat index.html | grep "projects.html"`

Expected: Line should be commented out

**Step 8: Create summary**

List all files modified:
- `_config.yml`
- `_includes/header.html`
- `_includes/about.html`
- `index.html`
- `_includes/footer.html` (if changes were needed)

---

## Post-Implementation

After all tasks complete:

1. **Test locally** (if npm/Jekyll available): `npm run dev` or `jekyll serve`
2. **Use superpowers:requesting-code-review** to verify work meets design
3. **Use superpowers:finishing-a-development-branch** to decide: merge, PR, or cleanup
