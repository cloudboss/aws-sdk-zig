const std = @import("std");

/// Optional. Use Quality tuning level to choose how you want to trade off
/// encoding speed for output video quality. The default behavior is faster,
/// lower quality, single-pass encoding.
pub const Mpeg2QualityTuningLevel = enum {
    single_pass,
    multi_pass,

    pub const json_field_names = .{
        .single_pass = "SINGLE_PASS",
        .multi_pass = "MULTI_PASS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_pass => "SINGLE_PASS",
            .multi_pass => "MULTI_PASS",
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
