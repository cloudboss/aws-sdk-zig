const EmbeddedConvert608To708 = @import("embedded_convert_608_to_708.zig").EmbeddedConvert608To708;
const EmbeddedTerminateCaptions = @import("embedded_terminate_captions.zig").EmbeddedTerminateCaptions;

/// Settings for embedded captions Source
pub const EmbeddedSourceSettings = struct {
    /// Specify whether this set of input captions appears in your outputs in both
    /// 608 and 708 format. If you choose Upconvert, MediaConvert includes the
    /// captions data in two ways: it passes the 608 data through using the 608
    /// compatibility bytes fields of the 708 wrapper, and it also translates the
    /// 608 data into 708.
    convert_608_to_708: ?EmbeddedConvert608To708,

    /// Specifies the 608/708 channel number within the video track from which to
    /// extract captions. Unused for passthrough.
    source_608_channel_number: ?i32,

    /// Specifies the video track index used for extracting captions. The system
    /// only supports one input video track, so this should always be set to '1'.
    source_608_track_number: ?i32,

    /// By default, the service terminates any unterminated captions at the end of
    /// each input. If you want the caption to continue onto your next input,
    /// disable this setting.
    terminate_captions: ?EmbeddedTerminateCaptions,

    pub const json_field_names = .{
        .convert_608_to_708 = "Convert608To708",
        .source_608_channel_number = "Source608ChannelNumber",
        .source_608_track_number = "Source608TrackNumber",
        .terminate_captions = "TerminateCaptions",
    };
};
