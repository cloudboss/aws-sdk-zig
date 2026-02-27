pub const Logical = enum {
    @"and",
    any,

    pub const json_field_names = .{
        .@"and" = "AND",
        .any = "ANY",
    };
};
