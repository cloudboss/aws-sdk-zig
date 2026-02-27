pub const ForwardedIPPosition = enum {
    first,
    last,
    any,

    pub const json_field_names = .{
        .first = "FIRST",
        .last = "LAST",
        .any = "ANY",
    };
};
