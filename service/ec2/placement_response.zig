/// Describes the placement of an instance.
pub const PlacementResponse = struct {
    /// The name of the placement group that the instance is in.
    group_name: ?[]const u8 = null,
};
