const EmbeddedConvert608To708 = @import("embedded_convert_608_to_708.zig").EmbeddedConvert608To708;
const EmbeddedScte20Detection = @import("embedded_scte_20_detection.zig").EmbeddedScte20Detection;

/// Embedded Source Settings
pub const EmbeddedSourceSettings = struct {
    /// If upconvert, 608 data is both passed through via the "608 compatibility
    /// bytes" fields of the 708 wrapper as well as translated into 708. 708 data
    /// present in the source content will be discarded.
    convert_608_to_708: ?EmbeddedConvert608To708,

    /// Set to "auto" to handle streams with intermittent and/or non-aligned SCTE-20
    /// and Embedded captions.
    scte_20_detection: ?EmbeddedScte20Detection,

    /// Specifies the 608/708 channel number within the video track from which to
    /// extract captions. Unused for passthrough.
    source_608_channel_number: ?i32,

    /// This field is unused and deprecated.
    source_608_track_number: ?i32,

    pub const json_field_names = .{
        .convert_608_to_708 = "Convert608To708",
        .scte_20_detection = "Scte20Detection",
        .source_608_channel_number = "Source608ChannelNumber",
        .source_608_track_number = "Source608TrackNumber",
    };
};
