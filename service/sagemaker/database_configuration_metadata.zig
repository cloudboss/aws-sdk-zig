const DatabaseConfigurationRollbackStatus = @import("database_configuration_rollback_status.zig").DatabaseConfigurationRollbackStatus;

/// Metadata information about a change to the external Slurm accounting
/// database of a HyperPod cluster.
pub const DatabaseConfigurationMetadata = struct {
    /// Additional information about a change that succeeded, such as an action to
    /// take on the cluster.
    advisory: ?[]const u8 = null,

    /// An error message describing why the accounting database change failed, and
    /// how to resolve it.
    failure_message: ?[]const u8 = null,

    /// Whether HyperPod restored the previous accounting database configuration
    /// after the change failed. Valid values:
    ///
    /// * `NotApplicable`: The change failed before HyperPod modified the cluster,
    ///   for example because the database could not be reached or rejected the
    ///   credentials, so there was nothing to restore.
    /// * `Reverted`: The change failed after it was applied, and HyperPod restored
    ///   the previous configuration. The cluster continues to use the previous
    ///   accounting database.
    /// * `RevertFailed`: The change failed and HyperPod could not restore the
    ///   previous configuration, so Slurm accounting on the cluster might not be
    ///   working.
    ///
    /// This field is omitted when the change succeeds.
    rollback_status: ?DatabaseConfigurationRollbackStatus = null,

    pub const json_field_names = .{
        .advisory = "Advisory",
        .failure_message = "FailureMessage",
        .rollback_status = "RollbackStatus",
    };
};
