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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
