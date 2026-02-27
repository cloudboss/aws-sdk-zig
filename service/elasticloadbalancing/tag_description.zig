const Tag = @import("tag.zig").Tag;

/// The tags associated with a load balancer.
pub const TagDescription = struct {
    /// The name of the load balancer.
    load_balancer_name: ?[]const u8,

    /// The tags.
    tags: ?[]const Tag,
};
