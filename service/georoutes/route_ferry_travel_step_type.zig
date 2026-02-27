pub const RouteFerryTravelStepType = enum {
    depart,
    @"continue",
    arrive,

    pub const json_field_names = .{
        .depart = "DEPART",
        .@"continue" = "CONTINUE",
        .arrive = "ARRIVE",
    };
};
