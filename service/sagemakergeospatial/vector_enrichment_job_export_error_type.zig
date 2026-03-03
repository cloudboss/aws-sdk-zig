const std = @import("std");

pub const VectorEnrichmentJobExportErrorType = enum {
    client_error,
    server_error,

    pub const json_field_names = .{
        .client_error = "CLIENT_ERROR",
        .server_error = "SERVER_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .client_error => "CLIENT_ERROR",
            .server_error => "SERVER_ERROR",
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
