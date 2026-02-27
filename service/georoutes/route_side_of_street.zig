pub const RouteSideOfStreet = enum {
    left,
    right,

    pub const json_field_names = .{
        .left = "LEFT",
        .right = "RIGHT",
    };
};
