const Scte20Convert608To708 = @import("scte_20_convert_608_to_708.zig").Scte20Convert608To708;

/// Scte20 Source Settings
pub const Scte20SourceSettings = struct {
    /// If upconvert, 608 data is both passed through via the "608 compatibility
    /// bytes" fields of the 708 wrapper as well as translated into 708. 708 data
    /// present in the source content will be discarded.
    convert_608_to_708: ?Scte20Convert608To708,

    /// Specifies the 608/708 channel number within the video track from which to
    /// extract captions. Unused for passthrough.
    source_608_channel_number: ?i32,

    pub const json_field_names = .{
        .convert_608_to_708 = "Convert608To708",
        .source_608_channel_number = "Source608ChannelNumber",
    };
};
