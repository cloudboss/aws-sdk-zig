const std = @import("std");

pub const RouteServerRouteStatus = enum {
    in_rib,
    in_fib,

    pub const json_field_names = .{
        .in_rib = "in-rib",
        .in_fib = "in-fib",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_rib => "in-rib",
            .in_fib => "in-fib",
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
