/// The environment for the workload.
pub const WorkloadEnvironment = enum {
    production,
    preproduction,

    pub const json_field_names = .{
        .production = "PRODUCTION",
        .preproduction = "PREPRODUCTION",
    };
};
