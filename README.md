Steps to setup a Unity repo:

1. Create a new repository from this repository (there's some "use template" button on github).

2. Make sure you have both `git` and `git-lfs` installed. If you're on mac, install these via Homebrew.
   ```
   brew install git
   brew install git-lfs
   ```

3. Clone the repository onto your computer. You can use a graphical tool like GitHub Desktop, or just do:
   ```
   git clone link-to-repo
   ```

4. Run `git lfs install` in the root of the repo to make sure that Git LFS is enabled.
   
5. Add the unity folder into the project.
   You can check if Git LFS works correctly by showing the diff for a large file, like an FBX, in the console (first I'm staging it, then showing the diff):
   ```
   git add something.fbx
   git diff --cached something.fbx
   ```
      The output should be something like this:
   ```
   +version https://git-lfs.github.com/spec/v1
   +oid sha256:8f6717567b76aea297d723fe7725fe176105cd9bc29116aebfc6ff0afc4f929b
   +size 56646
   ```
   You can also check if it works in GitHub Desktop by clicking one of the changes and seeing the diff on the right.

5. Stage all added things. This command may take a while to process, because Unity projects can potentially have thousands of files.
   ```
   git add --all
   ```

6. Do the first commit. This will take even longer to process. I think, at this point Git LFS kicks in sending files to the server.
   ```
   git commit -m "Commit Unity files"
   ```

7. Commit the changes to the remote. This one may hang forever on 100% completion, in which case you should check if the commit has appeared on the remote, and then you can safely kill it.
   ```
   git push
   ```


If you realize you've made a mistake, perhaps the Library folder did not get ignored, you can do a soft reset to a commit before you've added the files, and then modify your gitignore, after which you can stage your changes again:
```
# Show latest commits.
# Copy the hash of a working commit.
git log

# Go back to that commit without discarding changes.
# After this you can modify the gitignore.
git reset --soft commit-hash-you-copied

# Stage all files, do a commit
git add --all
git commit -m "Commmit project files"

# Rewrite the git history on the remote
git push --force-with-lease
```