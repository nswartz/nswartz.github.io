# Portfolio Site Content Update Design

**Date:** 2026-01-29
**Author:** Noah Swartz

## Overview

Update the portfolio website to reflect actual resume content instead of placeholder text. The site will showcase professional experience, technical skills, and personal interests while maintaining a clean, focused design.

## Key Decisions

### Content Strategy
- **Source of truth:** Resume PDF (Resume-2025.pdf) for all professional information
- **Approach:** Centralize data in `_config.yml` for consistency and maintainability
- **Scope:** Update header, about section, and configuration; hide projects section until ready

### Visual Structure
- **Skills organization:** Frontend / Backend / Infrastructure (replacing Design / Code / Tools)
- **Personal touch:** Add "When I'm Not Coding" subsection for theatre/choir background
- **Social presence:** Email and GitHub only (remove Twitter and Google+)
- **Projects:** Hide section but keep code for future use

## Configuration Changes

### _config.yml Updates

**Add new fields:**
```yaml
user_title: "Full Stack Engineer"
user_description: "Specializing in TypeScript, React, React Native, .NET, and AWS. Experienced across frontend, backend, mobile, and cloud infrastructure."
location: "Elkhorn, NE"
```

**Keep existing:**
- `username: "Noah Swartz"`
- `email: "nswartz1990@gmail.com"`
- `github_username: "nswartz"`

**Leave commented/empty:**
- `twitter_username` (commented out)
- `gplus_username` (commented out)
- `google-analytics.id: ""` (empty string disables tracking)

## Header Updates (_includes/header.html)

### Display
- **Name:** Noah Swartz (from `{{site.username}}`)
- **Subtitle:** Full Stack Engineer (from `{{site.user_title}}`)

### Social Links
Remove Twitter and Google+ icons entirely. Keep only:
- **Email icon:** Links to `mailto:{{site.email}}`
- **GitHub icon:** Links to `https://github.com/{{site.github_username}}`

### Navigation
- Keep: "About Me" link
- Remove: "Projects" link (section will be hidden)

## About Section Restructure (_includes/about.html)

### Header
- **Title:** "My Expertise"
- **Intro:** Display `{{site.user_description}}`

### Frontend Section
**Icons (devicons):**
- TypeScript (`devicon-typescript-plain`)
- React (`devicon-react-original`)
- React Native (`devicon-react-original` or similar)

**Description (2-3 sentences):**
Highlight React/React Native expertise, TypeScript conversion leadership at Hudl, building responsive UIs and mobile interfaces for sports analysts.

### Backend Section
**Icons (devicons):**
- .NET/C# (`devicon-dotnetcore-plain` or `devicon-csharp-plain`)
- Python (`devicon-python-plain`)
- Node.js (`devicon-nodejs-plain`)

**Description (2-3 sentences):**
Focus on building APIs and data services, collaborating with overseas teams on backend requirements, leading major package version upgrades.

### Infrastructure Section
**Icons (devicons):**
- AWS (`devicon-amazonwebservices-plain-wordmark`)
- MongoDB (`devicon-mongodb-plain`)
- Jest (`devicon-jest-plain` or testing icon)

**Description (2-3 sentences):**
Emphasize cloud infrastructure work (AWS S3/IoT/DocDB), database management, testing frameworks (Jest/XUnit/unittest), and reliability improvements.

### Personal Interests Subsection

**Placement:** Below the three technical skill sections, after a subtle divider

**Heading:** "When I'm Not Coding" (or alternative: "Outside Work", "Off the Clock")

**Content:**
- **Theatre:** "Major speaking/singing roles in high school and college plays and musicals"
- **Choir:** "Member of select vocal ensembles, including a performance at Carnegie Hall"

**Styling:**
- Visually lighter than technical sections
- Simple Font Awesome icons (theater masks, music note) or just text
- Adds personality without overwhelming technical focus

## Projects Section (_includes/projects.html)

**Action:** Comment out the entire section in the main layout/index file

**Rationale:** No projects ready to showcase yet

**Future:** Keep `_includes/projects.html` intact in repository for easy re-enabling later

## Footer & Analytics

### Footer (_includes/footer.html)
- Keep existing structure (copyright/credits)
- Remove any "Nathan Randecker" references if they exist
- Remove Google Analytics references if present

### Google Analytics (_includes/google-analytics.html)
- Leave `google-analytics.id` as empty string in config
- Effectively disables tracking without removing infrastructure
- Can be enabled later by adding tracking ID

## Files to Modify

1. `_config.yml` - Add user_title, user_description, location
2. `_includes/header.html` - Update social links, add subtitle support
3. `_includes/about.html` - Complete restructure (skills + personal interests)
4. `index.html` (or main layout) - Comment out projects section include
5. `_includes/footer.html` - Verify no placeholder names

## Implementation Notes

- Use existing devicon classes for technology icons
- Maintain Jekyll/Liquid template syntax
- Preserve existing CSS classes for styling consistency
- Write concise, professional descriptions (no placeholder text)
- Test locally with `gulp` dev server before deployment

## Success Criteria

- [ ] All placeholder text replaced with real content
- [ ] Skills accurately reflect resume
- [ ] Personal interests add personality without detracting from professionalism
- [ ] Social links work correctly (email and GitHub)
- [ ] Projects section hidden but code preserved
- [ ] Site renders correctly in dev environment
- [ ] No references to previous template author remain
