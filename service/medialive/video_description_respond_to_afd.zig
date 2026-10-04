const std = @import("std");

/// Video Description Respond To Afd
pub const VideoDescriptionRespondToAfd = enum {
    none,
    passthrough,
    respond,

    pub const json_field_names = .{
        .none = "NONE",
        .passthrough = "PASSTHROUGH",
        .respond = "RESPOND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .passthrough => "PASSTHROUGH",
            .respond => "RESPOND",
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
