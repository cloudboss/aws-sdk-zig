const std = @import("std");

pub const ControlOperationType = enum {
    enable_control,
    disable_control,
    update_enabled_control,
    reset_enabled_control,

    pub const json_field_names = .{
        .enable_control = "ENABLE_CONTROL",
        .disable_control = "DISABLE_CONTROL",
        .update_enabled_control = "UPDATE_ENABLED_CONTROL",
        .reset_enabled_control = "RESET_ENABLED_CONTROL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enable_control => "ENABLE_CONTROL",
            .disable_control => "DISABLE_CONTROL",
            .update_enabled_control => "UPDATE_ENABLED_CONTROL",
            .reset_enabled_control => "RESET_ENABLED_CONTROL",
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
