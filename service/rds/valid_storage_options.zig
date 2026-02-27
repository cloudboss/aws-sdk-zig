const DoubleRange = @import("double_range.zig").DoubleRange;
const Range = @import("range.zig").Range;

/// Information about valid modifications that you can make to your DB instance.
/// Contains the result of a successful call to the
/// `DescribeValidDBInstanceModifications` action.
pub const ValidStorageOptions = struct {
    /// The valid range of Provisioned IOPS to gibibytes of storage multiplier. For
    /// example, 3-10, which means that provisioned IOPS can be between 3 and 10
    /// times storage.
    iops_to_storage_ratio: ?[]const DoubleRange,

    /// The valid range of provisioned IOPS. For example, 1000-256,000.
    provisioned_iops: ?[]const Range,

    /// The valid range of provisioned storage throughput. For example, 500-4,000
    /// mebibytes per second (MiBps).
    provisioned_storage_throughput: ?[]const Range,

    /// The valid range of storage in gibibytes (GiB). For example, 100 to 16,384.
    storage_size: ?[]const Range,

    /// The valid range of storage throughput to provisioned IOPS ratios. For
    /// example, 0-0.25.
    storage_throughput_to_iops_ratio: ?[]const DoubleRange,

    /// The valid storage types for your DB instance. For example: gp2, gp3, io1,
    /// io2.
    storage_type: ?[]const u8,

    /// Indicates whether or not Amazon RDS can automatically scale storage for DB
    /// instances that use the new instance class.
    supports_storage_autoscaling: ?bool,
};
