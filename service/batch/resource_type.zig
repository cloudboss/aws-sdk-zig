pub const ResourceType = enum {
    gpu,
    vcpu,
    memory,

    pub const json_field_names = .{
        .gpu = "GPU",
        .vcpu = "VCPU",
        .memory = "MEMORY",
    };
};
