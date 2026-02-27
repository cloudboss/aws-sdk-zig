pub const RoutePedestrianTravelStepType = enum {
    arrive,
    @"continue",
    depart,
    keep,
    roundabout_enter,
    roundabout_exit,
    roundabout_pass,
    turn,
    exit,
    ramp,
    u_turn,

    pub const json_field_names = .{
        .arrive = "ARRIVE",
        .@"continue" = "CONTINUE",
        .depart = "DEPART",
        .keep = "KEEP",
        .roundabout_enter = "ROUNDABOUT_ENTER",
        .roundabout_exit = "ROUNDABOUT_EXIT",
        .roundabout_pass = "ROUNDABOUT_PASS",
        .turn = "TURN",
        .exit = "EXIT",
        .ramp = "RAMP",
        .u_turn = "U_TURN",
    };
};
