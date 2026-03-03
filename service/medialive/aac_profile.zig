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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
