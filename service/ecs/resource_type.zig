pub const ResourceType = enum {
    gpu,
    inference_accelerator,

    pub const json_field_names = .{
        .gpu = "GPU",
        .inference_accelerator = "INFERENCE_ACCELERATOR",
    };
};
