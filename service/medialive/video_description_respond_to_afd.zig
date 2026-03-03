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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
