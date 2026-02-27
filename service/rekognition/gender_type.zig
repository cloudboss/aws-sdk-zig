pub const GenderType = enum {
    male,
    female,

    pub const json_field_names = .{
        .male = "Male",
        .female = "Female",
    };
};
