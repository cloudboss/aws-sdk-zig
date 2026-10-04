const std = @import("std");

pub const RateBasedStatementAggregateKeyType = enum {
    ip,
    forwarded_ip,
    custom_keys,
    constant,

    pub const json_field_names = .{
        .ip = "IP",
        .forwarded_ip = "FORWARDED_IP",
        .custom_keys = "CUSTOM_KEYS",
        .constant = "CONSTANT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ip => "IP",
            .forwarded_ip => "FORWARDED_IP",
            .custom_keys => "CUSTOM_KEYS",
            .constant => "CONSTANT",
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
