const CaptionRectangle = @import("caption_rectangle.zig").CaptionRectangle;

/// Teletext Source Settings
pub const TeletextSourceSettings = struct {
    /// Optionally defines a region where TTML style captions will be displayed
    output_rectangle: ?CaptionRectangle = null,

    /// Specifies the teletext page number within the data stream from which to
    /// extract captions. Range of 0x100 (256) to 0x8FF (2303). Unused for
    /// passthrough. Should be specified as a hexadecimal string with no "0x"
    /// prefix.
    page_number: ?[]const u8 = null,

    pub const json_field_names = .{
        .output_rectangle = "OutputRectangle",
        .page_number = "PageNumber",
    };
};
