pub const RouteTravelStepType = enum {
    default,
    turn_by_turn,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .turn_by_turn = "TURN_BY_TURN",
    };
};
