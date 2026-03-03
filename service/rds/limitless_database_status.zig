const std = @import("std");

pub const LimitlessDatabaseStatus = enum {
    active,
    not_in_use,
    enabled,
    disabled,
    enabling,
    disabling,
    modifying_max_capacity,
    @"error",

    pub const json_field_names = .{
        .active = "active",
        .not_in_use = "not-in-use",
        .enabled = "enabled",
        .disabled = "disabled",
        .enabling = "enabling",
        .disabling = "disabling",
        .modifying_max_capacity = "modifying-max-capacity",
        .@"error" = "error",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "active",
            .not_in_use => "not-in-use",
            .enabled => "enabled",
            .disabled => "disabled",
            .enabling => "enabling",
            .disabling => "disabling",
            .modifying_max_capacity => "modifying-max-capacity",
            .@"error" => "error",
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
