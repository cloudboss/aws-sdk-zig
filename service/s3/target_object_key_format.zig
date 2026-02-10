const PartitionedPrefix = @import("partitioned_prefix.zig").PartitionedPrefix;
const SimplePrefix = @import("simple_prefix.zig").SimplePrefix;

/// Amazon S3 key format for log objects. Only one format, PartitionedPrefix or
/// SimplePrefix, is
/// allowed.
pub const TargetObjectKeyFormat = struct {
    /// Partitioned S3 key for log objects.
    partitioned_prefix: ?PartitionedPrefix,

    /// To use the simple format for S3 keys for log objects. To specify
    /// SimplePrefix format, set
    /// SimplePrefix to {}.
    simple_prefix: ?SimplePrefix,
};
