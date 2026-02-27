pub const AngleUnits = enum {
    degree_angle,
    radian,

    pub const json_field_names = .{
        .degree_angle = "DEGREE_ANGLE",
        .radian = "RADIAN",
    };
};
