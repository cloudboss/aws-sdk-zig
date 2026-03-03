const Tag = @import("tag.zig").Tag;

/// Usage allocations allow you to split usage into buckets by tags.
///
/// Each `UsageAllocation` indicates the usage quantity for a specific set of
/// tags.
pub const UsageAllocation = struct {
    /// The total quantity allocated to this bucket of usage.
    allocated_usage_quantity: i32,

    /// The set of tags that define the bucket of usage. For the bucket of items
    /// with no tags,
    /// this parameter can be left out.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .allocated_usage_quantity = "AllocatedUsageQuantity",
        .tags = "Tags",
    };
};
