const std = @import("std");

pub const CreditSharingType = enum {
    default,
    disabled,
    custom,
    cost_category_rule,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .disabled = "DISABLED",
        .custom = "CUSTOM",
        .cost_category_rule = "COST_CATEGORY_RULE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .disabled => "DISABLED",
            .custom => "CUSTOM",
            .cost_category_rule => "COST_CATEGORY_RULE",
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
