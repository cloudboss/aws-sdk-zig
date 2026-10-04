const std = @import("std");

/// Always keep the default value (SELF_CONTAINED) for this setting.
pub const MovReference = enum {
    self_contained,
    external,

    pub const json_field_names = .{
        .self_contained = "SELF_CONTAINED",
        .external = "EXTERNAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .self_contained => "SELF_CONTAINED",
            .external => "EXTERNAL",
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
