const std = @import("std");

pub const ApiCachingBehavior = enum {
    full_request_caching,
    per_resolver_caching,
    operation_level_caching,

    pub const json_field_names = .{
        .full_request_caching = "FULL_REQUEST_CACHING",
        .per_resolver_caching = "PER_RESOLVER_CACHING",
        .operation_level_caching = "OPERATION_LEVEL_CACHING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .full_request_caching => "FULL_REQUEST_CACHING",
            .per_resolver_caching => "PER_RESOLVER_CACHING",
            .operation_level_caching => "OPERATION_LEVEL_CACHING",
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
