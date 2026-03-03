const std = @import("std");

pub const RuleOrder = enum {
    strict_order,
    default_action_order,

    pub const json_field_names = .{
        .strict_order = "STRICT_ORDER",
        .default_action_order = "DEFAULT_ACTION_ORDER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .strict_order => "STRICT_ORDER",
            .default_action_order => "DEFAULT_ACTION_ORDER",
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
