const std = @import("std");

pub const DeleteUniqueIdErrorType = enum {
    service_error,
    validation_error,

    pub const json_field_names = .{
        .service_error = "SERVICE_ERROR",
        .validation_error = "VALIDATION_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service_error => "SERVICE_ERROR",
            .validation_error => "VALIDATION_ERROR",
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
