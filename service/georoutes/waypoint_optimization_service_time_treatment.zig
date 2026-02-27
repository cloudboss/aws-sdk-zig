pub const WaypointOptimizationServiceTimeTreatment = enum {
    rest,
    work,

    pub const json_field_names = .{
        .rest = "REST",
        .work = "WORK",
    };
};
