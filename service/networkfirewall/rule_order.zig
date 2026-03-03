const std = @import("std");

pub const RuleOrder = enum {
    default_action_order,
    strict_order,

    pub const json_field_names = .{
        .default_action_order = "DEFAULT_ACTION_ORDER",
        .strict_order = "STRICT_ORDER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default_action_order => "DEFAULT_ACTION_ORDER",
            .strict_order => "STRICT_ORDER",
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
