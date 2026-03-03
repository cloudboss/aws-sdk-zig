const std = @import("std");

pub const IpamPoolCidrFailureCode = enum {
    cidr_not_available,
    limit_exceeded,

    pub const json_field_names = .{
        .cidr_not_available = "cidr-not-available",
        .limit_exceeded = "limit-exceeded",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cidr_not_available => "cidr-not-available",
            .limit_exceeded => "limit-exceeded",
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
