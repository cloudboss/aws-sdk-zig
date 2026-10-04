const PartitionTransform = @import("partition_transform.zig").PartitionTransform;

/// Specifies a single partition field.
pub const PartitionField = struct {
    /// The name of the source column used for partitioning. This column must be of
    /// the `timestamptz` type.
    source_name: []const u8,

    /// The partition transform to apply. The only valid value is `TIME_HOUR`.
    transform: PartitionTransform,

    pub const json_field_names = .{
        .source_name = "SourceName",
        .transform = "Transform",
    };
};
