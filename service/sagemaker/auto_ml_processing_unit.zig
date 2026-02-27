pub const AutoMLProcessingUnit = enum {
    cpu,
    gpu,

    pub const json_field_names = .{
        .cpu = "CPU",
        .gpu = "GPU",
    };
};
