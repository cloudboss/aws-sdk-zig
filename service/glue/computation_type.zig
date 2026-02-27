pub const ComputationType = enum {
    full,
    incremental,

    pub const json_field_names = .{
        .full = "FULL",
        .incremental = "INCREMENTAL",
    };
};
