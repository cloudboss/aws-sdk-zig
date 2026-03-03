const std = @import("std");

pub const PolicyExistenceCondition = enum {
    policy_must_exist,
    policy_must_not_exist,

    pub const json_field_names = .{
        .policy_must_exist = "POLICY_MUST_EXIST",
        .policy_must_not_exist = "POLICY_MUST_NOT_EXIST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .policy_must_exist => "POLICY_MUST_EXIST",
            .policy_must_not_exist => "POLICY_MUST_NOT_EXIST",
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
