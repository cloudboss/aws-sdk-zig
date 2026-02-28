const TableBucketType = @import("table_bucket_type.zig").TableBucketType;

/// Contains details about a table bucket.
pub const TableBucketSummary = struct {
    /// The Amazon Resource Name (ARN) of the table bucket.
    arn: []const u8,

    /// The date and time the table bucket was created at.
    created_at: i64,

    /// The name of the table bucket.
    name: []const u8,

    /// The ID of the account that owns the table bucket.
    owner_account_id: []const u8,

    /// The system-assigned unique identifier for the table bucket.
    table_bucket_id: ?[]const u8,

    /// The type of the table bucket.
    @"type": ?TableBucketType,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .name = "name",
        .owner_account_id = "ownerAccountId",
        .table_bucket_id = "tableBucketId",
        .@"type" = "type",
    };
};
