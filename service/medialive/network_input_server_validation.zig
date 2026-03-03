const std = @import("std");

/// Network Input Server Validation
pub const NetworkInputServerValidation = enum {
    check_cryptography_and_validate_name,
    check_cryptography_only,

    pub const json_field_names = .{
        .check_cryptography_and_validate_name = "CHECK_CRYPTOGRAPHY_AND_VALIDATE_NAME",
        .check_cryptography_only = "CHECK_CRYPTOGRAPHY_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .check_cryptography_and_validate_name => "CHECK_CRYPTOGRAPHY_AND_VALIDATE_NAME",
            .check_cryptography_only => "CHECK_CRYPTOGRAPHY_ONLY",
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
