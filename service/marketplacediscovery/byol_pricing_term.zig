const TermType = @import("term_type.zig").TermType;

/// Defines a Bring Your Own License (BYOL) pricing term, where buyers use their
/// existing license for the product.
pub const ByolPricingTerm = struct {
    /// The unique identifier of the term.
    id: []const u8,

    /// The category of the term.
    type: TermType,

    pub const json_field_names = .{
        .id = "id",
        .type = "type",
    };
};
