const X12Envelope = @import("x12_envelope.zig").X12Envelope;

/// A container for outbound EDI options.
pub const OutboundEdiOptions = union(enum) {
    /// A structure that contains an X12 envelope structure.
    x_12: ?X12Envelope,

    pub const json_field_names = .{
        .x_12 = "x12",
    };
};
