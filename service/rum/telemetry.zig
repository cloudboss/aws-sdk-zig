const std = @import("std");

pub const Telemetry = enum {
    /// Includes JS error event plugin
    errors,
    /// Includes navigation, paint, resource and web vital event plugins
    performance,
    /// Includes X-Ray Xhr and X-Ray Fetch plugin
    http,

    pub const json_field_names = .{
        .errors = "errors",
        .performance = "performance",
        .http = "http",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .errors => "errors",
            .performance => "performance",
            .http => "http",
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
