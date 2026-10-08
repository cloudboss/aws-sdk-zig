const TermType = @import("term_type.zig").TermType;

/// Defines a support term that includes the refund policy for the offer.
pub const SupportTerm = struct {
    /// The unique identifier of the term.
    id: []const u8,

    /// The refund policy description for the offer.
    refund_policy: []const u8,

    /// The category of the term.
    type: TermType,

    pub const json_field_names = .{
        .id = "id",
        .refund_policy = "refundPolicy",
        .type = "type",
    };
};
