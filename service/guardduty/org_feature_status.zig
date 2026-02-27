pub const OrgFeatureStatus = enum {
    new,
    none,
    all,

    pub const json_field_names = .{
        .new = "NEW",
        .none = "NONE",
        .all = "ALL",
    };
};
