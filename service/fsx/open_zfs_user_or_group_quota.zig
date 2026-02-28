const OpenZFSQuotaType = @import("open_zfs_quota_type.zig").OpenZFSQuotaType;

/// Used to configure quotas that define how much storage a user or group can
/// use on an
/// FSx for OpenZFS volume. For more information, see
/// [Volume
/// properties](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/managing-volumes.html#volume-properties)
/// in the FSx for OpenZFS User Guide.
pub const OpenZFSUserOrGroupQuota = struct {
    /// The ID of the user or group that the quota applies to.
    id: i32,

    /// The user or group's storage quota, in gibibytes (GiB).
    storage_capacity_quota_gi_b: i32,

    /// Specifies whether the quota applies to a user or group.
    @"type": OpenZFSQuotaType,

    pub const json_field_names = .{
        .id = "Id",
        .storage_capacity_quota_gi_b = "StorageCapacityQuotaGiB",
        .@"type" = "Type",
    };
};
