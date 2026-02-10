const Tag = @import("tag.zig").Tag;

/// Describes a customer-owned address pool.
pub const CoipPool = struct {
    /// The ID of the local gateway route table.
    local_gateway_route_table_id: ?[]const u8,

    /// The ARN of the address pool.
    pool_arn: ?[]const u8,

    /// The address ranges of the address pool.
    pool_cidrs: ?[]const []const u8,

    /// The ID of the address pool.
    pool_id: ?[]const u8,

    /// The tags.
    tags: ?[]const Tag,
};
