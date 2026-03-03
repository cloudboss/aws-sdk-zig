const X12InboundEdiOptions = @import("x12_inbound_edi_options.zig").X12InboundEdiOptions;

/// Contains options for processing inbound EDI files. These options allow for
/// customizing how incoming EDI documents are processed.
pub const InboundEdiOptions = struct {
    /// A structure that contains X12-specific options for processing inbound X12
    /// EDI files.
    x_12: ?X12InboundEdiOptions = null,

    pub const json_field_names = .{
        .x_12 = "x12",
    };
};
