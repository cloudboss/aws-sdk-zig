const X12OutboundEdiHeaders = @import("x12_outbound_edi_headers.zig").X12OutboundEdiHeaders;
const WrapOptions = @import("wrap_options.zig").WrapOptions;

/// A wrapper structure for an X12 definition object.
///
/// the X12 envelope ensures the integrity of the data and the efficiency of the
/// information exchange. The X12 message structure has hierarchical levels.
/// From highest to the lowest, they are:
///
/// * Interchange Envelope
/// * Functional Group
/// * Transaction Set
pub const X12Envelope = struct {
    /// A container for the X12 outbound EDI headers.
    common: ?X12OutboundEdiHeaders = null,

    wrap_options: ?WrapOptions = null,

    pub const json_field_names = .{
        .common = "common",
        .wrap_options = "wrapOptions",
    };
};
