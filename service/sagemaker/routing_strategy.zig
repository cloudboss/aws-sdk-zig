const std = @import("std");

pub const RoutingStrategy = enum {
    least_outstanding_requests,
    random,

    pub const json_field_names = .{
        .least_outstanding_requests = "LEAST_OUTSTANDING_REQUESTS",
        .random = "RANDOM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .least_outstanding_requests => "LEAST_OUTSTANDING_REQUESTS",
            .random => "RANDOM",
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
