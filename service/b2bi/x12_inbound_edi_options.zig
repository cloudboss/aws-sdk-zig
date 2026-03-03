const X12AcknowledgmentOptions = @import("x12_acknowledgment_options.zig").X12AcknowledgmentOptions;

/// Contains options specific to processing inbound X12 EDI files.
pub const X12InboundEdiOptions = struct {
    /// Specifies acknowledgment options for inbound X12 EDI files. These options
    /// control how functional and technical acknowledgments are handled.
    acknowledgment_options: ?X12AcknowledgmentOptions = null,

    pub const json_field_names = .{
        .acknowledgment_options = "acknowledgmentOptions",
    };
};
