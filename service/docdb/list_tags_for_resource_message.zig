const Filter = @import("filter.zig").Filter;

/// Represents the input to ListTagsForResource.
pub const ListTagsForResourceMessage = struct {
    /// This parameter is not currently supported.
    filters: ?[]const Filter = null,

    /// The Amazon DocumentDB resource with tags to be listed. This value is an
    /// Amazon Resource Name
    /// (ARN).
    resource_name: []const u8,
};
