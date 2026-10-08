const GrantItem = @import("grant_item.zig").GrantItem;
const TermType = @import("term_type.zig").TermType;

/// Defines a free trial pricing term that enables customers to try the product
/// before purchasing.
pub const FreeTrialPricingTerm = struct {
    /// The duration of the free trial period.
    duration: ?[]const u8 = null,

    /// The entitlements granted to the buyer during the free trial.
    grants: []const GrantItem,

    /// The unique identifier of the term.
    id: []const u8,

    /// The category of the term.
    type: TermType,

    pub const json_field_names = .{
        .duration = "duration",
        .grants = "grants",
        .id = "id",
        .type = "type",
    };
};
