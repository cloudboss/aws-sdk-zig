const std = @import("std");

pub const DestinationStatus = enum {
    enabling,
    active,
    disabling,
    disabled,
    enable_failed,
    updating,

    pub const json_field_names = .{
        .enabling = "ENABLING",
        .active = "ACTIVE",
        .disabling = "DISABLING",
        .disabled = "DISABLED",
        .enable_failed = "ENABLE_FAILED",
        .updating = "UPDATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabling => "ENABLING",
            .active => "ACTIVE",
            .disabling => "DISABLING",
            .disabled => "DISABLED",
            .enable_failed => "ENABLE_FAILED",
            .updating => "UPDATING",
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
