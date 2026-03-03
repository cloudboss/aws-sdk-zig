const std = @import("std");

pub const VerificationFailedReason = enum {
    invalid_mac,
    invalid_pin,
    invalid_validation_data,
    invalid_auth_request_cryptogram,

    pub const json_field_names = .{
        .invalid_mac = "INVALID_MAC",
        .invalid_pin = "INVALID_PIN",
        .invalid_validation_data = "INVALID_VALIDATION_DATA",
        .invalid_auth_request_cryptogram = "INVALID_AUTH_REQUEST_CRYPTOGRAM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_mac => "INVALID_MAC",
            .invalid_pin => "INVALID_PIN",
            .invalid_validation_data => "INVALID_VALIDATION_DATA",
            .invalid_auth_request_cryptogram => "INVALID_AUTH_REQUEST_CRYPTOGRAM",
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
