pub const BatchResourceRequirementType = enum {
    gpu,
    memory,
    vcpu,

    pub const json_field_names = .{
        .gpu = "GPU",
        .memory = "MEMORY",
        .vcpu = "VCPU",
    };
};
