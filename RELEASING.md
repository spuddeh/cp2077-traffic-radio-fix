# Releasing

This repo publishes Traffic Radio Fix to **GitHub Releases** and **Nexus Mods** via
[`.github/workflows/release.yml`](.github/workflows/release.yml), driven by
[`release-manifest.json`](release-manifest.json). Nothing is built: the workflow zips the committed `r6`
folder.

| Artifact id | What | File on Nexus |
| --- | --- | --- |
| `traffic-radio-fix` | The script and the tweak | main |

## First release is manual (then it automates)

A Nexus **file id does not exist until a file has been uploaded once**, so the first upload cannot come
from CI.

1. **Create the Nexus mod page.** Requirements: TweakXL and redscript; RedLogger as optional. Paste
   `nexus_description.bbc` as the description. The page is 34659, already in `release-manifest.json` as
   `nexus_mod_id`.
2. **Build the first zip locally** and upload it by hand:
   ```pwsh
   Compress-Archive -Path "r6" -DestinationPath "TrafficRadioFix_v1.0.0.zip" -Force
   ```
3. **Set the file id as a repository VARIABLE** `NEXUS_FILE_ID_TRAFFIC_RADIO_FIX` (Settings > Secrets and
   variables > Actions > **Variables**). Read it from the Files tab > **API Info**, where Nexus labels it
   **"Group ID"**. Never take it from the public v1 API, which has a different id under the same name.
4. **Add the API key secret** `NEXUSMODS_API_KEY`.

## Before any release

The version in the git tag must agree with the `Mod Version:` header in the `.reds` and `.yaml`,
`@changelog.md`, `nexus_changelog.md` and `currentVersion` in `release-manifest.json`. Run
`release-check.ps1 -Mod TrafficRadioFix`.

After a game patch, regenerate the table in `TrafficRadioFix.reds` from the patched
`base\sound\metadata\cooked_metadata.audio_metadata` and re-check which records need the static tweak.

## Cutting a release

Create a GitHub Release tagged `traffic-radio-fix-v<version>`. Its body is the Nexus changelog: plain
lines after the marker, no markdown headings or bullets.
