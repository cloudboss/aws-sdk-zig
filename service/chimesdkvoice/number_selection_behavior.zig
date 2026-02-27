pub const NumberSelectionBehavior = enum {
    prefer_sticky,
    avoid_sticky,

    pub const json_field_names = .{
        .prefer_sticky = "PreferSticky",
        .avoid_sticky = "AvoidSticky",
    };
};
