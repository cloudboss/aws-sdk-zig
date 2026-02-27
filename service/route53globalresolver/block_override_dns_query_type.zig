pub const BlockOverrideDnsQueryType = enum {
    cname,

    pub const json_field_names = .{
        .cname = "CNAME",
    };
};
