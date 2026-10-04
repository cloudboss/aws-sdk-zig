const std = @import("std");

/// The log level for system logs from the Lambda runtime. Possible values:
/// `DEBUG`, `INFO`, `WARN`.
pub const SystemLogLevel = enum {
    debug,
    info,
    warn,

    pub const json_field_names = .{
        .debug = "DEBUG",
        .info = "INFO",
        .warn = "WARN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .debug => "DEBUG",
            .info => "INFO",
            .warn => "WARN",
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
