const std = @import("std");

pub const FailedReportErrorCode = enum {
    insufficient_permissions,
    invalid_resource,
    configuration_error,

    pub const json_field_names = .{
        .insufficient_permissions = "insufficientPermissions",
        .invalid_resource = "invalidResource",
        .configuration_error = "configurationError",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insufficient_permissions => "insufficientPermissions",
            .invalid_resource => "invalidResource",
            .configuration_error => "configurationError",
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
