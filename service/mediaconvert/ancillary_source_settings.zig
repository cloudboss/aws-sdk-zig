const AncillaryConvert608To708 = @import("ancillary_convert_608_to_708.zig").AncillaryConvert608To708;
const AncillaryTerminateCaptions = @import("ancillary_terminate_captions.zig").AncillaryTerminateCaptions;

/// Settings for ancillary captions source.
pub const AncillarySourceSettings = struct {
    /// Specify whether this set of input captions appears in your outputs in both
    /// 608 and 708 format. If you choose Upconvert, MediaConvert includes the
    /// captions data in two ways: it passes the 608 data through using the 608
    /// compatibility bytes fields of the 708 wrapper, and it also translates the
    /// 608 data into 708.
    convert_608_to_708: ?AncillaryConvert608To708,

    /// Specifies the 608 channel number in the ancillary data track from which to
    /// extract captions. Unused for passthrough.
    source_ancillary_channel_number: ?i32,

    /// By default, the service terminates any unterminated captions at the end of
    /// each input. If you want the caption to continue onto your next input,
    /// disable this setting.
    terminate_captions: ?AncillaryTerminateCaptions,

    pub const json_field_names = .{
        .convert_608_to_708 = "Convert608To708",
        .source_ancillary_channel_number = "SourceAncillaryChannelNumber",
        .terminate_captions = "TerminateCaptions",
    };
};
