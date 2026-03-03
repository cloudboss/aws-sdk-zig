const PartitionField = @import("partition_field.zig").PartitionField;

/// Represents how to produce partition data for a table. Partition data is
/// produced by
/// transforming columns in a table. Each column transform is represented by a
/// named
/// `PartitionField`.
///
/// Here is an example of the schema in JSON.
///
/// `"partitionSpec": { "identity": [ {"sourceName": "column1"}, {"sourceName":
/// "column2"}, {"sourceName": "column3"} ] }`
///
/// Amazon Data Firehose is in preview release and is subject to change.
pub const PartitionSpec = struct {
    /// List of identity
    /// [transforms](https://iceberg.apache.org/spec/#partition-transforms) that
    /// performs an identity transformation. The transform takes the
    /// source value, and does not modify it. Result type is the source type.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    identity: ?[]const PartitionField = null,

    pub const json_field_names = .{
        .identity = "Identity",
    };
};
