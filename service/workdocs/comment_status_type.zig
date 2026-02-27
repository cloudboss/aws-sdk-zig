pub const CommentStatusType = enum {
    draft,
    published,
    deleted,

    pub const json_field_names = .{
        .draft = "DRAFT",
        .published = "PUBLISHED",
        .deleted = "DELETED",
    };
};
