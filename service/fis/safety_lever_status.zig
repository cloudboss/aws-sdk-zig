pub const SafetyLeverStatus = enum {
    disengaged,
    engaged,
    engaging,

    pub const json_field_names = .{
        .disengaged = "DISENGAGED",
        .engaged = "ENGAGED",
        .engaging = "ENGAGING",
    };
};
