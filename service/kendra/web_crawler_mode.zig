const std = @import("std");

pub const WebCrawlerMode = enum {
    host_only,
    subdomains,
    everything,

    pub const json_field_names = .{
        .host_only = "HOST_ONLY",
        .subdomains = "SUBDOMAINS",
        .everything = "EVERYTHING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .host_only => "HOST_ONLY",
            .subdomains => "SUBDOMAINS",
            .everything => "EVERYTHING",
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
