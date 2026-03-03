const aws = @import("aws");

const KeyspacesCellValue = @import("keyspaces_cell_value.zig").KeyspacesCellValue;
const KeyspacesRow = @import("keyspaces_row.zig").KeyspacesRow;
const OriginType = @import("origin_type.zig").OriginType;

/// Represents a change data capture record for a row in an Amazon Keyspaces
/// table, containing both the new and old states of the row.
pub const Record = struct {
    /// The clustering key columns and their values for the affected row, which
    /// determine the order of rows within a partition.
    clustering_keys: ?[]const aws.map.MapEntry(KeyspacesCellValue) = null,

    /// The timestamp indicating when this change data capture record was created.
    created_at: ?i64 = null,

    /// The version of the record format, used to track the evolution of the record
    /// structure over time.
    event_version: ?[]const u8 = null,

    /// The state of the row after the change operation that generated this record.
    new_image: ?KeyspacesRow = null,

    /// The state of the row before the change operation that generated this record.
    old_image: ?KeyspacesRow = null,

    /// The origin or source of this change data capture record.
    origin: ?OriginType = null,

    /// The partition key columns and their values for the affected row.
    partition_keys: ?[]const aws.map.MapEntry(KeyspacesCellValue) = null,

    /// A unique identifier assigned to this record within the shard, used for
    /// ordering and tracking purposes.
    sequence_number: ?[]const u8 = null,

    pub const json_field_names = .{
        .clustering_keys = "clusteringKeys",
        .created_at = "createdAt",
        .event_version = "eventVersion",
        .new_image = "newImage",
        .old_image = "oldImage",
        .origin = "origin",
        .partition_keys = "partitionKeys",
        .sequence_number = "sequenceNumber",
    };
};
