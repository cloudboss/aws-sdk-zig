const PlacementGroupStrategy = @import("placement_group_strategy.zig").PlacementGroupStrategy;

/// Describes the placement group support of the instance type.
pub const PlacementGroupInfo = struct {
    /// The supported placement group types.
    supported_strategies: ?[]const PlacementGroupStrategy,
};
