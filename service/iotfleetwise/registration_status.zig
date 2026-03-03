const std = @import("std");

pub const RegistrationStatus = enum {
    registration_pending,
    registration_success,
    registration_failure,

    pub const json_field_names = .{
        .registration_pending = "REGISTRATION_PENDING",
        .registration_success = "REGISTRATION_SUCCESS",
        .registration_failure = "REGISTRATION_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .registration_pending => "REGISTRATION_PENDING",
            .registration_success => "REGISTRATION_SUCCESS",
            .registration_failure => "REGISTRATION_FAILURE",
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
