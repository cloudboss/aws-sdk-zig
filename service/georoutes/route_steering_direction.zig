pub const RouteSteeringDirection = enum {
    left,
    right,
    straight,

    pub const json_field_names = .{
        .left = "LEFT",
        .right = "RIGHT",
        .straight = "STRAIGHT",
    };
};
