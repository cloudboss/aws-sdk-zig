pub const Directionality = enum {
    uni,
    multi,

    pub const json_field_names = .{
        .uni = "UNI",
        .multi = "MULTI",
    };
};
