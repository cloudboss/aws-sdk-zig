const std = @import("std");

/// The processing unit allocation that determines the vCPU, memory, and GPU
/// resources assigned to a task. Available units depend on the processing type.
pub const ProcessingUnit = enum {
    units_2,
    units_4,
    units_8,
    units_12,
    units_16,
    units_24,
    units_32,
    units_36,
    units_48,
    units_60,
    units_64,
    units_72,
    units_84,
    units_96,

    pub const json_field_names = .{
        .units_2 = "UNITS_2",
        .units_4 = "UNITS_4",
        .units_8 = "UNITS_8",
        .units_12 = "UNITS_12",
        .units_16 = "UNITS_16",
        .units_24 = "UNITS_24",
        .units_32 = "UNITS_32",
        .units_36 = "UNITS_36",
        .units_48 = "UNITS_48",
        .units_60 = "UNITS_60",
        .units_64 = "UNITS_64",
        .units_72 = "UNITS_72",
        .units_84 = "UNITS_84",
        .units_96 = "UNITS_96",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .units_2 => "UNITS_2",
            .units_4 => "UNITS_4",
            .units_8 => "UNITS_8",
            .units_12 => "UNITS_12",
            .units_16 => "UNITS_16",
            .units_24 => "UNITS_24",
            .units_32 => "UNITS_32",
            .units_36 => "UNITS_36",
            .units_48 => "UNITS_48",
            .units_60 => "UNITS_60",
            .units_64 => "UNITS_64",
            .units_72 => "UNITS_72",
            .units_84 => "UNITS_84",
            .units_96 => "UNITS_96",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
