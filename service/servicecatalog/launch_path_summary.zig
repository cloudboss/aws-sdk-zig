const ConstraintSummary = @import("constraint_summary.zig").ConstraintSummary;
const Tag = @import("tag.zig").Tag;

/// Summary information about a product path for a user.
pub const LaunchPathSummary = struct {
    /// The constraints on the portfolio-product relationship.
    constraint_summaries: ?[]const ConstraintSummary = null,

    /// The identifier of the product path.
    id: ?[]const u8 = null,

    /// The name of the portfolio that contains the product.
    name: ?[]const u8 = null,

    /// The tags associated with this product path.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .constraint_summaries = "ConstraintSummaries",
        .id = "Id",
        .name = "Name",
        .tags = "Tags",
    };
};
