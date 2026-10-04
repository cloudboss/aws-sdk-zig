const std = @import("std");

/// The reason for the query throttling, for example, when it exceeds the
/// concurrent query
/// limit.
pub const ThrottleReason = enum {
    concurrent_query_limit_exceeded,

    pub const json_field_names = .{
        .concurrent_query_limit_exceeded = "CONCURRENT_QUERY_LIMIT_EXCEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .concurrent_query_limit_exceeded => "CONCURRENT_QUERY_LIMIT_EXCEEDED",
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
