/// Contains a list of values defining partitions.
pub const PartitionValueList = struct {
    /// The list of values.
    values: []const []const u8,

    pub const json_field_names = .{
        .values = "Values",
    };
};
