pub const RouteLegType = enum {
    ferry,
    pedestrian,
    vehicle,

    pub const json_field_names = .{
        .ferry = "FERRY",
        .pedestrian = "PEDESTRIAN",
        .vehicle = "VEHICLE",
    };
};
