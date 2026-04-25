const std = @import("std");

/// The type of a notify template.
///
/// * `OTP_VERIFICATION` - OTP verification template type.
pub const NotifyTemplateType = enum {
    otp_verification,

    pub const json_field_names = .{
        .otp_verification = "OTP_VERIFICATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .otp_verification => "OTP_VERIFICATION",
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
