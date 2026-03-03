const std = @import("std");

pub const TransitGatewayPropagationState = enum {
    enabling,
    enabled,
    disabling,
    disabled,

    pub const json_field_names = .{
        .enabling = "enabling",
        .enabled = "enabled",
        .disabling = "disabling",
        .disabled = "disabled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabling => "enabling",
            .enabled => "enabled",
            .disabling => "disabling",
            .disabled => "disabled",
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
