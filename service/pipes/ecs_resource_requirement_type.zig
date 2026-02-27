pub const EcsResourceRequirementType = enum {
    gpu,
    inference_accelerator,

    pub const json_field_names = .{
        .gpu = "GPU",
        .inference_accelerator = "InferenceAccelerator",
    };
};
