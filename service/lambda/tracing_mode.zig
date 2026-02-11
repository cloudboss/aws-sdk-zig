pub const TracingMode = enum {
    active,
    pass_through,

    pub const json_field_names = .{
        .active = "Active",
        .pass_through = "PassThrough",
    };
};
