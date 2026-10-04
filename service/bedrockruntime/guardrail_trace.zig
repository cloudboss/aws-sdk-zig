const std = @import("std");

pub const GuardrailTrace = enum {
    enabled,
    disabled,
    enabled_full,

    pub const json_field_names = .{
        .enabled = "enabled",
        .disabled = "disabled",
        .enabled_full = "enabled_full",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "enabled",
            .disabled => "disabled",
            .enabled_full => "enabled_full",
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
