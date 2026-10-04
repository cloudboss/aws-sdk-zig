const std = @import("std");

/// Aac Profile
pub const AacProfile = enum {
    hev1,
    hev2,
    lc,

    pub const json_field_names = .{
        .hev1 = "HEV1",
        .hev2 = "HEV2",
        .lc = "LC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hev1 => "HEV1",
            .hev2 => "HEV2",
            .lc => "LC",
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
