const std = @import("std");

/// The type of MFA device used by the approver
///
/// * `EMAIL_OTP`: The approver will receive emailed one-time passwords to their
///   primary email
pub const MfaType = enum {
    email_otp,

    pub const json_field_names = .{
        .email_otp = "EMAIL_OTP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .email_otp => "EMAIL_OTP",
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
