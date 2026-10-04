const std = @import("std");

/// Global Configuration Output Timing Source
pub const GlobalConfigurationOutputTimingSource = enum {
    input_clock,
    system_clock,

    pub const json_field_names = .{
        .input_clock = "INPUT_CLOCK",
        .system_clock = "SYSTEM_CLOCK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .input_clock => "INPUT_CLOCK",
            .system_clock => "SYSTEM_CLOCK",
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
