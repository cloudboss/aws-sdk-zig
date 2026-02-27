pub const BlockOverrideDnsType = enum {
    cname,

    pub const json_field_names = .{
        .cname = "CNAME",
    };
};
