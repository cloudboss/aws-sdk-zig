const SpreadLevel = @import("spread_level.zig").SpreadLevel;
const PlacementGroupState = @import("placement_group_state.zig").PlacementGroupState;
const PlacementStrategy = @import("placement_strategy.zig").PlacementStrategy;
const Tag = @import("tag.zig").Tag;

/// Describes a placement group.
pub const PlacementGroup = struct {
    /// The Amazon Resource Name (ARN) of the placement group.
    group_arn: ?[]const u8,

    /// The ID of the placement group.
    group_id: ?[]const u8,

    /// The name of the placement group.
    group_name: ?[]const u8,

    /// Reserved for future use.
    linked_group_id: ?[]const u8,

    /// The number of partitions. Valid only if **strategy** is
    /// set to `partition`.
    partition_count: ?i32,

    /// The spread level for the placement group. *Only* Outpost placement
    /// groups can be spread across hosts.
    spread_level: ?SpreadLevel,

    /// The state of the placement group.
    state: ?PlacementGroupState,

    /// The placement strategy.
    strategy: ?PlacementStrategy,

    /// Any tags applied to the placement group.
    tags: ?[]const Tag,
};
