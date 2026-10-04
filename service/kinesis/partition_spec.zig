const PartitionField = @import("partition_field.zig").PartitionField;

/// Specifies how the destination table is partitioned.
pub const PartitionSpec = struct {
    /// The list of partition fields.
    partition_fields: []const PartitionField,

    pub const json_field_names = .{
        .partition_fields = "PartitionFields",
    };
};
