pub const SafetyLeverStatusInput = enum {
    disengaged,
    engaged,

    pub const json_field_names = .{
        .disengaged = "DISENGAGED",
        .engaged = "ENGAGED",
    };
};
