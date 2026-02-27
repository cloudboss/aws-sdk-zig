pub const RelatedItemType = enum {
    contact,
    comment,
    file,
    sla,
    connect_case,
    custom,

    pub const json_field_names = .{
        .contact = "CONTACT",
        .comment = "COMMENT",
        .file = "FILE",
        .sla = "SLA",
        .connect_case = "CONNECT_CASE",
        .custom = "CUSTOM",
    };
};
