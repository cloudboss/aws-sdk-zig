pub const ResourceShareType = enum {
    foreign,
    all,

    pub const json_field_names = .{
        .foreign = "FOREIGN",
        .all = "ALL",
    };
};
