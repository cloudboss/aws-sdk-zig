pub const FlowPublishState = enum {
    published,
    draft,
    pending_approval,

    pub const json_field_names = .{
        .published = "PUBLISHED",
        .draft = "DRAFT",
        .pending_approval = "PENDING_APPROVAL",
    };
};
