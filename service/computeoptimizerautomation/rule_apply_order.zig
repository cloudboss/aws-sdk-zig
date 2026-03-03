const std = @import("std");

pub const RuleApplyOrder = enum {
    before_account_rules,
    after_account_rules,

    pub const json_field_names = .{
        .before_account_rules = "BeforeAccountRules",
        .after_account_rules = "AfterAccountRules",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .before_account_rules => "BeforeAccountRules",
            .after_account_rules => "AfterAccountRules",
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
