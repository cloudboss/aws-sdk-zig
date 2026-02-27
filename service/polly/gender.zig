pub const Gender = enum {
    female,
    male,

    pub const json_field_names = .{
        .female = "Female",
        .male = "Male",
    };
};
