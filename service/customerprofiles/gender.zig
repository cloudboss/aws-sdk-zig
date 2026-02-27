pub const Gender = enum {
    male,
    female,
    unspecified,

    pub const json_field_names = .{
        .male = "MALE",
        .female = "FEMALE",
        .unspecified = "UNSPECIFIED",
    };
};
