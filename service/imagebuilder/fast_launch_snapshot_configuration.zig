/// Configuration settings for creating and managing pre-provisioned snapshots
/// for a
/// fast-launch enabled Windows AMI.
pub const FastLaunchSnapshotConfiguration = struct {
    /// The number of pre-provisioned snapshots to keep on hand for a fast-launch
    /// enabled
    /// Windows AMI.
    target_resource_count: ?i32 = null,

    pub const json_field_names = .{
        .target_resource_count = "targetResourceCount",
    };
};
