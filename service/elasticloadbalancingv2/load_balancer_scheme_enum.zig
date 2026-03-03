const std = @import("std");

pub const LoadBalancerSchemeEnum = enum {
    internet_facing,
    internal,

    pub const json_field_names = .{
        .internet_facing = "internet-facing",
        .internal = "internal",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internet_facing => "internet-facing",
            .internal => "internal",
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
