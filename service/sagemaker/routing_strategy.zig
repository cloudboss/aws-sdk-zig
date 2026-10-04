const std = @import("std");

pub const RoutingStrategy = enum {
    least_outstanding_requests,
    random,
    prefix_aware,

    pub const json_field_names = .{
        .least_outstanding_requests = "LEAST_OUTSTANDING_REQUESTS",
        .random = "RANDOM",
        .prefix_aware = "PREFIX_AWARE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .least_outstanding_requests => "LEAST_OUTSTANDING_REQUESTS",
            .random => "RANDOM",
            .prefix_aware => "PREFIX_AWARE",
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
