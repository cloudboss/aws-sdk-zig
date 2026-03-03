const std = @import("std");

/// Ignore this setting unless you set Frame rate (framerateNumerator divided by
/// framerateDenominator) to 29.970. If your input framerate is 23.976, choose
/// Hard. Otherwise, keep the default value None. For more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/working-with-telecine-and-inverse-telecine.html.
pub const XavcHdProfileTelecine = enum {
    none,
    hard,

    pub const json_field_names = .{
        .none = "NONE",
        .hard = "HARD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .hard => "HARD",
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
