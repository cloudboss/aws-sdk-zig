const std = @import("std");

pub const BatchGetPolicyErrorCode = enum {
    policy_store_not_found,
    policy_not_found,
    policy_store_alias_not_found,

    pub const json_field_names = .{
        .policy_store_not_found = "POLICY_STORE_NOT_FOUND",
        .policy_not_found = "POLICY_NOT_FOUND",
        .policy_store_alias_not_found = "POLICY_STORE_ALIAS_NOT_FOUND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .policy_store_not_found => "POLICY_STORE_NOT_FOUND",
            .policy_not_found => "POLICY_NOT_FOUND",
            .policy_store_alias_not_found => "POLICY_STORE_ALIAS_NOT_FOUND",
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
