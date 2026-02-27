pub const KxAzMode = enum {
    single,
    multi,

    pub const json_field_names = .{
        .single = "SINGLE",
        .multi = "MULTI",
    };
};
