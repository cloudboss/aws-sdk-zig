const std = @import("std");

/// Controls the amount of phase-shift applied to the surround channels. Only
/// used for 3/2 coding mode.
pub const Eac3PhaseControl = enum {
    shift_90_degrees,
    no_shift,

    pub const json_field_names = .{
        .shift_90_degrees = "SHIFT_90_DEGREES",
        .no_shift = "NO_SHIFT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .shift_90_degrees => "SHIFT_90_DEGREES",
            .no_shift => "NO_SHIFT",
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
