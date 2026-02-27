/// If the IMSC captions track is intended to provide accessibility for people
/// who are deaf or hard of hearing: Set Accessibility subtitles to Enabled.
/// When you do, MediaConvert adds accessibility attributes to your output HLS
/// or DASH manifest. For HLS manifests, MediaConvert adds the following
/// accessibility attributes under EXT-X-MEDIA for this track:
/// CHARACTERISTICS="public.accessibility.transcribes-spoken-dialog,public.accessibility.describes-music-and-sound" and AUTOSELECT="YES". For DASH manifests, MediaConvert adds the following in the adaptation set for this track: . If the captions track is not intended to provide such accessibility: Keep the default value, Disabled. When you do, for DASH manifests, MediaConvert instead adds the following in the adaptation set for this track: .
pub const ImscAccessibilitySubs = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
