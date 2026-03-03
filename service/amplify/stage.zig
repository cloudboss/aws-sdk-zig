const std = @import("std");

pub const Stage = enum {
    production,
    beta,
    development,
    experimental,
    pull_request,

    pub const json_field_names = .{
        .production = "PRODUCTION",
        .beta = "BETA",
        .development = "DEVELOPMENT",
        .experimental = "EXPERIMENTAL",
        .pull_request = "PULL_REQUEST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .production => "PRODUCTION",
            .beta => "BETA",
            .development => "DEVELOPMENT",
            .experimental => "EXPERIMENTAL",
            .pull_request => "PULL_REQUEST",
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
