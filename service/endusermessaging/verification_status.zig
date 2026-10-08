const std = @import("std");

/// Outcome of a ValidateNotifyCodeVerification request.
pub const VerificationStatus = enum {
    /// The submitted code matches an active verification within its validity
    /// window.
    valid,
    /// The submitted code does not match, has expired, or has exceeded its attempt
    /// limit.
    invalid,

    pub const json_field_names = .{
        .valid = "VALID",
        .invalid = "INVALID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .valid => "VALID",
            .invalid => "INVALID",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
