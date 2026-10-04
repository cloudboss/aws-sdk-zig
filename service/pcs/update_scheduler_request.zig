/// The scheduler configuration for updating a cluster. Use this to specify the
/// scheduler version to update to.
pub const UpdateSchedulerRequest = struct {
    /// The scheduler version to update the cluster to. You can only update to a
    /// newer version. For more information about supported versions and update
    /// paths, see [Updating the scheduler version on a
    /// cluster](https://docs.aws.amazon.com/pcs/latest/userguide/working-with_clusters_version_update.html) in the *PCS User Guide*.
    ///
    /// Valid Values: `24.05 | 24.11 | 25.05 | 25.11 | 26.05`
    version: []const u8,

    pub const json_field_names = .{
        .version = "version",
    };
};
