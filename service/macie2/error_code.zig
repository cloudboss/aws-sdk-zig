const std = @import("std");

/// The source of an issue or delay. Possible values are:
pub const ErrorCode = enum {
    client_error,
    internal_error,

    pub const json_field_names = .{
        .client_error = "ClientError",
        .internal_error = "InternalError",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .client_error => "ClientError",
            .internal_error => "InternalError",
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
