const Tag = @import("tag.zig").Tag;

/// Describes an Outpost link aggregation group (LAG).
pub const OutpostLag = struct {
    /// The IDs of the local gateway virtual interfaces associated with the Outpost
    /// LAG.
    local_gateway_virtual_interface_ids: ?[]const []const u8 = null,

    /// The Amazon Resource Number (ARN) of the Outpost LAG.
    outpost_arn: ?[]const u8 = null,

    /// The ID of the Outpost LAG.
    outpost_lag_id: ?[]const u8 = null,

    /// The ID of the Outpost LAG owner.
    owner_id: ?[]const u8 = null,

    /// The service link virtual interface IDs associated with the Outpost LAG.
    service_link_virtual_interface_ids: ?[]const []const u8 = null,

    /// The current state of the Outpost LAG.
    state: ?[]const u8 = null,

    /// The tags associated with the Outpost LAG.
    tags: ?[]const Tag = null,
};
