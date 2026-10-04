const std = @import("std");

pub const AgentLifecycle = enum {
    preview,
    published,

    pub const json_field_names = .{
        .preview = "PREVIEW",
        .published = "PUBLISHED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .preview => "PREVIEW",
            .published => "PUBLISHED",
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
