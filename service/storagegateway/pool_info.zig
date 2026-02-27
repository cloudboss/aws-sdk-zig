const PoolStatus = @import("pool_status.zig").PoolStatus;
const RetentionLockType = @import("retention_lock_type.zig").RetentionLockType;
const TapeStorageClass = @import("tape_storage_class.zig").TapeStorageClass;

/// Describes a custom tape pool.
pub const PoolInfo = struct {
    /// The Amazon Resource Name (ARN) of the custom tape pool. Use the
    /// ListTapePools operation to return a list of custom tape pools for your
    /// account and Amazon Web Services Region.
    pool_arn: ?[]const u8,

    /// The name of the custom tape pool. `PoolName` can use all ASCII characters,
    /// except '/' and '\'.
    pool_name: ?[]const u8,

    /// Status of the custom tape pool. Pool can be `ACTIVE` or
    /// `DELETED`.
    pool_status: ?PoolStatus,

    /// Tape retention lock time is set in days. Tape retention lock can be enabled
    /// for up to
    /// 100 years (36,500 days).
    retention_lock_time_in_days: ?i32,

    /// Tape retention lock type, which can be configured in two modes. When
    /// configured in
    /// governance mode, Amazon Web Services accounts with specific IAM permissions
    /// are authorized
    /// to remove the tape retention lock from archived virtual tapes. When
    /// configured in
    /// compliance mode, the tape retention lock cannot be removed by any user,
    /// including the root
    /// Amazon Web Services account.
    retention_lock_type: ?RetentionLockType,

    /// The storage class that is associated with the custom pool. When you use your
    /// backup
    /// application to eject the tape, the tape is archived directly into the
    /// storage class (S3
    /// Glacier or S3 Glacier Deep Archive) that corresponds to the pool.
    storage_class: ?TapeStorageClass,

    pub const json_field_names = .{
        .pool_arn = "PoolARN",
        .pool_name = "PoolName",
        .pool_status = "PoolStatus",
        .retention_lock_time_in_days = "RetentionLockTimeInDays",
        .retention_lock_type = "RetentionLockType",
        .storage_class = "StorageClass",
    };
};
