const std = @import("std");

pub const JobType = enum {
    release,
    retry,
    manual,
    web_hook,

    pub const json_field_names = .{
        .release = "RELEASE",
        .retry = "RETRY",
        .manual = "MANUAL",
        .web_hook = "WEB_HOOK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .release => "RELEASE",
            .retry => "RETRY",
            .manual => "MANUAL",
            .web_hook => "WEB_HOOK",
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
