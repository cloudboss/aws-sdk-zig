/// Specify which audio tracks to dynamically select from your source. To select
/// all audio tracks: Keep the default value, All tracks. To select all audio
/// tracks with a specific language code: Choose Language code. When you do, you
/// must also specify a language code under the Language code setting. If there
/// is no matching Language code in your source, then no track will be selected.
pub const DynamicAudioSelectorType = enum {
    all_tracks,
    language_code,

    pub const json_field_names = .{
        .all_tracks = "ALL_TRACKS",
        .language_code = "LANGUAGE_CODE",
    };
};
