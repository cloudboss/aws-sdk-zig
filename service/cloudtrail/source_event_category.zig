pub const SourceEventCategory = enum {
    management,
    data,

    pub const json_field_names = .{
        .management = "Management",
        .data = "Data",
    };
};
