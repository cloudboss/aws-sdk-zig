const std = @import("std");

pub const IngressIpOperator = enum {
    cidr_matches,
    not_cidr_matches,

    pub const json_field_names = .{
        .cidr_matches = "CIDR_MATCHES",
        .not_cidr_matches = "NOT_CIDR_MATCHES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cidr_matches => "CIDR_MATCHES",
            .not_cidr_matches => "NOT_CIDR_MATCHES",
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
