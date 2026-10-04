const std = @import("std");

/// The severity level for a HyperPod cluster event.
pub const ClusterEventLevel = enum {
    info,
    warn,
    @"error",

    pub const json_field_names = .{
        .info = "Info",
        .warn = "Warn",
        .@"error" = "Error",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .info => "Info",
            .warn => "Warn",
            .@"error" => "Error",
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
