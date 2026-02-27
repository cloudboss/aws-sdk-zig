pub const ProductionVariantInferenceAmiVersion = enum {
    al2_gpu_2,
    al2_gpu_2_1,
    al2_gpu_3_1,
    al2_neuron_2,

    pub const json_field_names = .{
        .al2_gpu_2 = "AL2_GPU_2",
        .al2_gpu_2_1 = "AL2_GPU_2_1",
        .al2_gpu_3_1 = "AL2_GPU_3_1",
        .al2_neuron_2 = "AL2_NEURON_2",
    };
};
