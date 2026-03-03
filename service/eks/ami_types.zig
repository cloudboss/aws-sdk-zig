const std = @import("std");

pub const AMITypes = enum {
    al2_x_86_64,
    al2_x_86_64_gpu,
    al2_arm_64,
    custom,
    bottlerocket_arm_64,
    bottlerocket_x_86_64,
    bottlerocket_arm_64_fips,
    bottlerocket_x_86_64_fips,
    bottlerocket_arm_64_nvidia,
    bottlerocket_x_86_64_nvidia,
    bottlerocket_arm_64_nvidia_fips,
    bottlerocket_x_86_64_nvidia_fips,
    windows_core_2019_x_86_64,
    windows_full_2019_x_86_64,
    windows_core_2022_x_86_64,
    windows_full_2022_x_86_64,
    al2023_x_86_64_standard,
    al2023_arm_64_standard,
    al2023_x_86_64_neuron,
    al2023_x_86_64_nvidia,
    al2023_arm_64_nvidia,

    pub const json_field_names = .{
        .al2_x_86_64 = "AL2_x86_64",
        .al2_x_86_64_gpu = "AL2_x86_64_GPU",
        .al2_arm_64 = "AL2_ARM_64",
        .custom = "CUSTOM",
        .bottlerocket_arm_64 = "BOTTLEROCKET_ARM_64",
        .bottlerocket_x_86_64 = "BOTTLEROCKET_x86_64",
        .bottlerocket_arm_64_fips = "BOTTLEROCKET_ARM_64_FIPS",
        .bottlerocket_x_86_64_fips = "BOTTLEROCKET_x86_64_FIPS",
        .bottlerocket_arm_64_nvidia = "BOTTLEROCKET_ARM_64_NVIDIA",
        .bottlerocket_x_86_64_nvidia = "BOTTLEROCKET_x86_64_NVIDIA",
        .bottlerocket_arm_64_nvidia_fips = "BOTTLEROCKET_ARM_64_NVIDIA_FIPS",
        .bottlerocket_x_86_64_nvidia_fips = "BOTTLEROCKET_x86_64_NVIDIA_FIPS",
        .windows_core_2019_x_86_64 = "WINDOWS_CORE_2019_x86_64",
        .windows_full_2019_x_86_64 = "WINDOWS_FULL_2019_x86_64",
        .windows_core_2022_x_86_64 = "WINDOWS_CORE_2022_x86_64",
        .windows_full_2022_x_86_64 = "WINDOWS_FULL_2022_x86_64",
        .al2023_x_86_64_standard = "AL2023_x86_64_STANDARD",
        .al2023_arm_64_standard = "AL2023_ARM_64_STANDARD",
        .al2023_x_86_64_neuron = "AL2023_x86_64_NEURON",
        .al2023_x_86_64_nvidia = "AL2023_x86_64_NVIDIA",
        .al2023_arm_64_nvidia = "AL2023_ARM_64_NVIDIA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .al2_x_86_64 => "AL2_x86_64",
            .al2_x_86_64_gpu => "AL2_x86_64_GPU",
            .al2_arm_64 => "AL2_ARM_64",
            .custom => "CUSTOM",
            .bottlerocket_arm_64 => "BOTTLEROCKET_ARM_64",
            .bottlerocket_x_86_64 => "BOTTLEROCKET_x86_64",
            .bottlerocket_arm_64_fips => "BOTTLEROCKET_ARM_64_FIPS",
            .bottlerocket_x_86_64_fips => "BOTTLEROCKET_x86_64_FIPS",
            .bottlerocket_arm_64_nvidia => "BOTTLEROCKET_ARM_64_NVIDIA",
            .bottlerocket_x_86_64_nvidia => "BOTTLEROCKET_x86_64_NVIDIA",
            .bottlerocket_arm_64_nvidia_fips => "BOTTLEROCKET_ARM_64_NVIDIA_FIPS",
            .bottlerocket_x_86_64_nvidia_fips => "BOTTLEROCKET_x86_64_NVIDIA_FIPS",
            .windows_core_2019_x_86_64 => "WINDOWS_CORE_2019_x86_64",
            .windows_full_2019_x_86_64 => "WINDOWS_FULL_2019_x86_64",
            .windows_core_2022_x_86_64 => "WINDOWS_CORE_2022_x86_64",
            .windows_full_2022_x_86_64 => "WINDOWS_FULL_2022_x86_64",
            .al2023_x_86_64_standard => "AL2023_x86_64_STANDARD",
            .al2023_arm_64_standard => "AL2023_ARM_64_STANDARD",
            .al2023_x_86_64_neuron => "AL2023_x86_64_NEURON",
            .al2023_x_86_64_nvidia => "AL2023_x86_64_NVIDIA",
            .al2023_arm_64_nvidia => "AL2023_ARM_64_NVIDIA",
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
