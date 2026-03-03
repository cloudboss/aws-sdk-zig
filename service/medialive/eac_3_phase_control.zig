const std = @import("std");

/// Eac3 Phase Control
pub const Eac3PhaseControl = enum {
    no_shift,
    shift_90_degrees,

    pub const json_field_names = .{
        .no_shift = "NO_SHIFT",
        .shift_90_degrees = "SHIFT_90_DEGREES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_shift => "NO_SHIFT",
            .shift_90_degrees => "SHIFT_90_DEGREES",
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
