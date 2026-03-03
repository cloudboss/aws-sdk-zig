pub const ListCommentsItem = struct {
    body: ?[]const u8 = null,

    comment_id: []const u8,

    created_date: ?i64 = null,

    creator: ?[]const u8 = null,

    last_updated_by: ?[]const u8 = null,

    last_updated_date: ?i64 = null,

    pub const json_field_names = .{
        .body = "body",
        .comment_id = "commentId",
        .created_date = "createdDate",
        .creator = "creator",
        .last_updated_by = "lastUpdatedBy",
        .last_updated_date = "lastUpdatedDate",
    };
};
