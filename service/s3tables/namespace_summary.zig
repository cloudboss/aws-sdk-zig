/// Contains details about a namespace.
pub const NamespaceSummary = struct {
    /// The date and time the namespace was created at.
    created_at: i64,

    /// The ID of the account that created the namespace.
    created_by: []const u8,

    /// The name of the namespace.
    namespace: []const []const u8,

    /// The system-assigned unique identifier for the namespace.
    namespace_id: ?[]const u8,

    /// The ID of the account that owns the namespace.
    owner_account_id: []const u8,

    /// The system-assigned unique identifier for the table bucket that contains
    /// this namespace.
    table_bucket_id: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .namespace = "namespace",
        .namespace_id = "namespaceId",
        .owner_account_id = "ownerAccountId",
        .table_bucket_id = "tableBucketId",
    };
};
