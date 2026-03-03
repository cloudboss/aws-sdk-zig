const std = @import("std");

pub const RuleIpOperator = enum {
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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
