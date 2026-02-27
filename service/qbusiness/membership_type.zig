pub const MembershipType = enum {
    index,
    datasource,

    pub const json_field_names = .{
        .index = "INDEX",
        .datasource = "DATASOURCE",
    };
};
