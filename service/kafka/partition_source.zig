/// A source column used by an Apache Iceberg destination table's partition
/// specification.
pub const PartitionSource = struct {
    /// Source name.
    source_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_name = "SourceName",
    };
};
