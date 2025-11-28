# GitHub Pages Deployment Guide

## Current Setup

You have **one repository** for deployment:
- **rosie1028.github.io** (`origin`): `git@github.com:Rosie1028/rosie1028.github.io.git`
  - Branch: `main`
  - **This is your GitHub Pages repository**
  - GitHub Pages URL: `https://rosie1028.github.io/` (root URL)

## Which Branch to Use for GitHub Pages?

**Use the `main` branch on the rosie1028.github.io repository.**

This repository serves from the root URL, so:
- ✅ Base href should be `/` (not `/Portfolio/`)
- ✅ All Flutter web build files go in the root
- ✅ `.nojekyll` file tells GitHub Pages not to use Jekyll
- ✅ All assets, JavaScript, and HTML files in root

## GitHub Pages Configuration

The `rosie1028.github.io` repository automatically serves from the `main` branch.
- No configuration needed - it's automatic!
- GitHub Pages is automatically enabled for `username.github.io` repositories
- It serves from the root of the `main` branch

## How to Update Your Portfolio

### Step 1: Build the Flutter App
```bash
cd frontend
flutter build web
```

### Step 2: Copy Build Files to Root
```bash
cd ..
cp -r frontend/build/web/* .
```

### Step 3: Update Base Href (if needed)
Make sure `index.html` has:
```html
<base href="/">
```
(Note: Since you're using rosie1028.github.io, it's served from root, so base href is `/`)

### Step 4: Commit and Push
```bash
git checkout main
git add .
git commit -m "Update portfolio"
git push origin main
```

### Step 5: Wait 5-10 minutes
GitHub Pages will automatically rebuild your site.

## Quick Update Script

You can create a script to automate this:

```bash
#!/bin/bash
# Build and deploy to GitHub Pages

cd frontend
flutter build web
cd ..
cp -r frontend/build/web/* .
git checkout gh-pages-clean
git add .
git commit -m "Update portfolio - $(date)"
git push origin gh-pages-clean
echo "Deployment complete! Wait 5-10 minutes for GitHub Pages to update."
```

## Troubleshooting

- **Blank page**: Check browser console for errors, verify base href is correct
- **Old content showing**: Clear browser cache or wait 5-10 minutes
- **404 errors**: Make sure `.nojekyll` file exists in root
- **Assets not loading**: Verify base href matches your repository name

## Quick Deployment

Simply run:
```bash
./deploy.sh
```

This will:
1. Build your Flutter app
2. Copy files to root
3. Switch to main branch
4. Commit and push to origin (rosie1028.github.io)
5. GitHub Pages will automatically update

## Current Status

✅ Remote `origin` points to `rosie1028.github.io`
✅ Deployment script updated for root URL
✅ Base href set to `/` for root serving

Your portfolio will be live at: **https://rosie1028.github.io/**

