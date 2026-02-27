/// Limits that are applicable for given storage type.
pub const StorageTypeLimit = struct {
    /// Name of storage limits that are applicable for given storage type.
    /// If
    /// `
    /// StorageType
    /// `
    /// is ebs, following storage options are applicable
    ///
    /// * MinimumVolumeSize
    /// Minimum amount of volume size that is applicable for given storage type.It
    /// can be empty if it is not applicable.
    ///
    /// * MaximumVolumeSize
    /// Maximum amount of volume size that is applicable for given storage type.It
    /// can be empty if it is not applicable.
    ///
    /// * MaximumIops
    /// Maximum amount of Iops that is applicable for given storage type.It can be
    /// empty if it is not applicable.
    ///
    /// * MinimumIops
    /// Minimum amount of Iops that is applicable for given storage type.It can be
    /// empty if it is not applicable.
    ///
    /// * MaximumThroughput
    /// Maximum amount of Throughput that is applicable for given storage type.It
    /// can be empty if it is not applicable.
    ///
    /// * MinimumThroughput
    /// Minimum amount of Throughput that is applicable for given storage type.It
    /// can be empty if it is not applicable.
    limit_name: ?[]const u8,

    /// Values for the
    /// `
    /// StorageTypeLimit$LimitName
    /// `
    /// .
    limit_values: ?[]const []const u8,

    pub const json_field_names = .{
        .limit_name = "LimitName",
        .limit_values = "LimitValues",
    };
};
