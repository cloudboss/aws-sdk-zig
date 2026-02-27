/// Ignore this setting unless you are using FairPlay DRM with Verimatrix and
/// you encounter playback issues. Keep the default value, Include, to output
/// audio-only headers. Choose Exclude to remove the audio-only headers from
/// your audio segments.
pub const HlsAudioOnlyHeader = enum {
    include,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .exclude = "EXCLUDE",
    };
};
