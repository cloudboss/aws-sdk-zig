/// Configuration settings for creating and managing pre-provisioned snapshots
/// for a Windows
/// fast launch enabled Windows AMI.
pub const FastLaunchSnapshotConfigurationResponse = struct {
    /// The number of pre-provisioned snapshots requested to keep on hand for a
    /// Windows fast
    /// launch enabled AMI.
    target_resource_count: ?i32 = null,
};
