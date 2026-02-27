pub const DeploymentType = enum {
    in_place,
    blue_green,

    pub const json_field_names = .{
        .in_place = "IN_PLACE",
        .blue_green = "BLUE_GREEN",
    };
};
