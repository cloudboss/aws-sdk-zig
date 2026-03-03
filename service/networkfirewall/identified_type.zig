const std = @import("std");

pub const IdentifiedType = enum {
    stateless_rule_forwarding_asymmetrically,
    stateless_rule_contains_tcp_flags,

    pub const json_field_names = .{
        .stateless_rule_forwarding_asymmetrically = "STATELESS_RULE_FORWARDING_ASYMMETRICALLY",
        .stateless_rule_contains_tcp_flags = "STATELESS_RULE_CONTAINS_TCP_FLAGS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .stateless_rule_forwarding_asymmetrically => "STATELESS_RULE_FORWARDING_ASYMMETRICALLY",
            .stateless_rule_contains_tcp_flags => "STATELESS_RULE_CONTAINS_TCP_FLAGS",
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
