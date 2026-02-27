pub const ModelCardStatus = enum {
    draft,
    pendingreview,
    approved,
    archived,

    pub const json_field_names = .{
        .draft = "DRAFT",
        .pendingreview = "PENDINGREVIEW",
        .approved = "APPROVED",
        .archived = "ARCHIVED",
    };
};
