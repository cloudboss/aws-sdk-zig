const std = @import("std");

/// Optional. Use Quality tuning level to choose how you want to trade off
/// encoding speed for output video quality. The default behavior is faster,
/// lower quality, single-pass encoding.
pub const H265QualityTuningLevel = enum {
    single_pass,
    single_pass_hq,
    multi_pass_hq,

    pub const json_field_names = .{
        .single_pass = "SINGLE_PASS",
        .single_pass_hq = "SINGLE_PASS_HQ",
        .multi_pass_hq = "MULTI_PASS_HQ",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_pass => "SINGLE_PASS",
            .single_pass_hq => "SINGLE_PASS_HQ",
            .multi_pass_hq => "MULTI_PASS_HQ",
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
