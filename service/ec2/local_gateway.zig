const Tag = @import("tag.zig").Tag;

/// Describes a local gateway.
pub const LocalGateway = struct {
    /// The ID of the local gateway.
    local_gateway_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Outpost.
    outpost_arn: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the local gateway.
    owner_id: ?[]const u8 = null,

    /// The state of the local gateway.
    state: ?[]const u8 = null,

    /// The tags assigned to the local gateway.
    tags: ?[]const Tag = null,
};
