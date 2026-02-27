pub const IssueSubEntity = enum {
    comments,
    attachments,
    worklogs,

    pub const json_field_names = .{
        .comments = "COMMENTS",
        .attachments = "ATTACHMENTS",
        .worklogs = "WORKLOGS",
    };
};
