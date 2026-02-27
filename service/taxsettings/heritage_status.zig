pub const HeritageStatus = enum {
    opt_in,
    opt_out,

    pub const json_field_names = .{
        .opt_in = "OptIn",
        .opt_out = "OptOut",
    };
};
