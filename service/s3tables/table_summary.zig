const TableType = @import("table_type.zig").TableType;

/// Contains details about a table.
pub const TableSummary = struct {
    /// The date and time the table was created at.
    created_at: i64,

    /// The Amazon Web Services service managing this table, if applicable. For
    /// example, a replicated table is managed by the S3 Tables replication service.
    managed_by_service: ?[]const u8 = null,

    /// The date and time the table was last modified at.
    modified_at: i64,

    /// The name of the table.
    name: []const u8,

    /// The name of the namespace.
    namespace: []const []const u8,

    /// The unique identifier for the namespace that contains this table.
    namespace_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the table.
    table_arn: []const u8,

    /// The unique identifier for the table bucket that contains this table.
    table_bucket_id: ?[]const u8 = null,

    /// The type of the table.
    @"type": TableType,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .managed_by_service = "managedByService",
        .modified_at = "modifiedAt",
        .name = "name",
        .namespace = "namespace",
        .namespace_id = "namespaceId",
        .table_arn = "tableARN",
        .table_bucket_id = "tableBucketId",
        .@"type" = "type",
    };
};
