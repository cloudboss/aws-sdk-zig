const std = @import("std");

/// The processing type for compute resources. Determines whether the task runs
/// on standard CPU or GPU-accelerated hardware.
pub const ProcessingType = enum {
    generic_compute_processing,
    hardware_accelerated_processing,

    pub const json_field_names = .{
        .generic_compute_processing = "GENERIC_COMPUTE_PROCESSING",
        .hardware_accelerated_processing = "HARDWARE_ACCELERATED_PROCESSING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .generic_compute_processing => "GENERIC_COMPUTE_PROCESSING",
            .hardware_accelerated_processing => "HARDWARE_ACCELERATED_PROCESSING",
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
