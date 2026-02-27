const IndexStatus = @import("index_status.zig").IndexStatus;

/// Summary information for your Amazon Q Business index.
pub const Index = struct {
    /// The Unix timestamp when the index was created.
    created_at: ?i64,

    /// The name of the index.
    display_name: ?[]const u8,

    /// The identifier for the index.
    index_id: ?[]const u8,

    /// The current status of the index. When the status is `ACTIVE`, the index is
    /// ready.
    status: ?IndexStatus,

    /// The Unix timestamp when the index was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .display_name = "displayName",
        .index_id = "indexId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
