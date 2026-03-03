const std = @import("std");

pub const IpamPrefixListResolverRuleConditionOperation = enum {
    equals,
    not_equals,
    subnet_of,

    pub const json_field_names = .{
        .equals = "equals",
        .not_equals = "not-equals",
        .subnet_of = "subnet-of",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "equals",
            .not_equals => "not-equals",
            .subnet_of => "subnet-of",
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
