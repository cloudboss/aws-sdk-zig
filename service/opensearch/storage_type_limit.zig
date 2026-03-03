/// Limits that are applicable for the given Amazon OpenSearch Service storage
/// type.
pub const StorageTypeLimit = struct {
    /// Name of storage limits that are applicable for the given storage type. If
    /// `StorageType` is `ebs`, the following options are
    /// available:
    ///
    /// * **MinimumVolumeSize** - Minimum volume size that
    /// is available for the given storage type. Can be empty if not applicable.
    ///
    /// * **MaximumVolumeSize** - Maximum volume size that
    /// is available for the given storage type. Can be empty if not applicable.
    ///
    /// * **MaximumIops** - Maximum amount of IOPS that is
    /// available for the given the storage type. Can be empty if not applicable.
    ///
    /// * **MinimumIops** - Minimum amount of IOPS that is
    /// available for the given the storage type. Can be empty if not applicable.
    ///
    /// * **MaximumThroughput** - Maximum amount of
    /// throughput that is available for the given the storage type. Can be empty if
    /// not
    /// applicable.
    ///
    /// * **MinimumThroughput** - Minimum amount of
    /// throughput that is available for the given the storage type. Can be empty if
    /// not
    /// applicable.
    limit_name: ?[]const u8 = null,

    /// The limit values.
    limit_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .limit_name = "LimitName",
        .limit_values = "LimitValues",
    };
};
