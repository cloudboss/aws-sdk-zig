/// Configuration settings for creating and managing pre-provisioned snapshots
/// for a Windows
/// fast launch enabled AMI.
pub const FastLaunchSnapshotConfigurationRequest = struct {
    /// The number of pre-provisioned snapshots to keep on hand for a Windows fast
    /// launch enabled
    /// AMI.
    target_resource_count: ?i32,
};
