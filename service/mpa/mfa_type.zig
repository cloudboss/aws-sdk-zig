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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
