const std = @import("std");

pub const DatasetStatusMessageCode = enum {
    success,
    service_error,
    client_error,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .service_error = "SERVICE_ERROR",
        .client_error = "CLIENT_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "SUCCESS",
            .service_error => "SERVICE_ERROR",
            .client_error => "CLIENT_ERROR",
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
