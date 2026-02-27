/// Represents a single field in a `PartitionSpec`.
///
/// Amazon Data Firehose is in preview release and is subject to change.
pub const PartitionField = struct {
    /// The column name to be configured in partition spec.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    source_name: []const u8,

    pub const json_field_names = .{
        .source_name = "SourceName",
    };
};
