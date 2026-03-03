const std = @import("std");

pub const AppUnitErrorCategory = enum {
    credential_error,
    connectivity_error,
    permission_error,
    unsupported_error,
    other_error,

    pub const json_field_names = .{
        .credential_error = "CREDENTIAL_ERROR",
        .connectivity_error = "CONNECTIVITY_ERROR",
        .permission_error = "PERMISSION_ERROR",
        .unsupported_error = "UNSUPPORTED_ERROR",
        .other_error = "OTHER_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .credential_error => "CREDENTIAL_ERROR",
            .connectivity_error => "CONNECTIVITY_ERROR",
            .permission_error => "PERMISSION_ERROR",
            .unsupported_error => "UNSUPPORTED_ERROR",
            .other_error => "OTHER_ERROR",
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
