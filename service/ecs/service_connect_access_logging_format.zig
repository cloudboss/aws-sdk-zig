const std = @import("std");

/// The format for Service Connect access log output. Choose TEXT for
/// human-readable logs
/// or JSON for structured data that integrates well with log analysis tools.
pub const ServiceConnectAccessLoggingFormat = enum {
    text,
    json,

    pub const json_field_names = .{
        .text = "TEXT",
        .json = "JSON",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .text => "TEXT",
            .json => "JSON",
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
