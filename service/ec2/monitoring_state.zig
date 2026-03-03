const std = @import("std");

pub const MonitoringState = enum {
    disabled,
    disabling,
    enabled,
    pending,

    pub const json_field_names = .{
        .disabled = "disabled",
        .disabling = "disabling",
        .enabled = "enabled",
        .pending = "pending",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "disabled",
            .disabling => "disabling",
            .enabled => "enabled",
            .pending => "pending",
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
