const PartitionInput = @import("partition_input.zig").PartitionInput;

/// A structure that contains the values and structure used to update a
/// partition.
pub const BatchUpdatePartitionRequestEntry = struct {
    /// The structure used to update a partition.
    partition_input: PartitionInput,

    /// A list of values defining the partitions.
    partition_value_list: []const []const u8,

    pub const json_field_names = .{
        .partition_input = "PartitionInput",
        .partition_value_list = "PartitionValueList",
    };
};
