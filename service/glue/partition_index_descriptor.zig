const BackfillError = @import("backfill_error.zig").BackfillError;
const PartitionIndexStatus = @import("partition_index_status.zig").PartitionIndexStatus;
const KeySchemaElement = @import("key_schema_element.zig").KeySchemaElement;

/// A descriptor for a partition index in a table.
pub const PartitionIndexDescriptor = struct {
    /// A list of errors that can occur when registering partition indexes for an
    /// existing table.
    backfill_errors: ?[]const BackfillError,

    /// The name of the partition index.
    index_name: []const u8,

    /// The status of the partition index.
    ///
    /// The possible statuses are:
    ///
    /// * CREATING: The index is being created. When an index is in a CREATING
    ///   state, the index or its table cannot be deleted.
    ///
    /// * ACTIVE: The index creation succeeds.
    ///
    /// * FAILED: The index creation fails.
    ///
    /// * DELETING: The index is deleted from the list of indexes.
    index_status: PartitionIndexStatus,

    /// A list of one or more keys, as `KeySchemaElement` structures, for the
    /// partition index.
    keys: []const KeySchemaElement,

    pub const json_field_names = .{
        .backfill_errors = "BackfillErrors",
        .index_name = "IndexName",
        .index_status = "IndexStatus",
        .keys = "Keys",
    };
};
