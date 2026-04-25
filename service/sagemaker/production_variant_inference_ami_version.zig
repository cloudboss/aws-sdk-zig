const std = @import("std");

pub const ProductionVariantInferenceAmiVersion = enum {
    al2_gpu_2,
    al2_gpu_2_1,
    al2_gpu_3_1,
    al2_neuron_2,
    al2023_gpu_4_1,

    pub const json_field_names = .{
        .al2_gpu_2 = "al2-ami-sagemaker-inference-gpu-2",
        .al2_gpu_2_1 = "al2-ami-sagemaker-inference-gpu-2-1",
        .al2_gpu_3_1 = "al2-ami-sagemaker-inference-gpu-3-1",
        .al2_neuron_2 = "al2-ami-sagemaker-inference-neuron-2",
        .al2023_gpu_4_1 = "al2023-ami-sagemaker-inference-gpu-4-1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .al2_gpu_2 => "al2-ami-sagemaker-inference-gpu-2",
            .al2_gpu_2_1 => "al2-ami-sagemaker-inference-gpu-2-1",
            .al2_gpu_3_1 => "al2-ami-sagemaker-inference-gpu-3-1",
            .al2_neuron_2 => "al2-ami-sagemaker-inference-neuron-2",
            .al2023_gpu_4_1 => "al2023-ami-sagemaker-inference-gpu-4-1",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
