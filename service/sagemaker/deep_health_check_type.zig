pub const DeepHealthCheckType = enum {
    instance_stress,
    instance_connectivity,

    pub const json_field_names = .{
        .instance_stress = "INSTANCE_STRESS",
        .instance_connectivity = "INSTANCE_CONNECTIVITY",
    };
};
