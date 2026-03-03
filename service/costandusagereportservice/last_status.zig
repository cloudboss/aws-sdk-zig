const std = @import("std");

pub const LastStatus = enum {
    success,
    error_permissions,
    error_no_bucket,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .error_permissions = "ERROR_PERMISSIONS",
        .error_no_bucket = "ERROR_NO_BUCKET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "SUCCESS",
            .error_permissions => "ERROR_PERMISSIONS",
            .error_no_bucket => "ERROR_NO_BUCKET",
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
