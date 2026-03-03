const std = @import("std");

/// The action to take if the required MX record can't be found when you send an
/// email.
/// When you set this value to `UseDefaultValue`, the mail is sent using
/// *amazonses.com* as the MAIL FROM domain. When you set this value
/// to `RejectMessage`, the Amazon SES API v2 returns a
/// `MailFromDomainNotVerified` error, and doesn't attempt to deliver the
/// email.
///
/// These behaviors are taken when the custom MAIL FROM domain configuration is
/// in the
/// `Pending`, `Failed`, and `TemporaryFailure`
/// states.
pub const BehaviorOnMxFailure = enum {
    use_default_value,
    reject_message,

    pub const json_field_names = .{
        .use_default_value = "USE_DEFAULT_VALUE",
        .reject_message = "REJECT_MESSAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .use_default_value => "USE_DEFAULT_VALUE",
            .reject_message => "REJECT_MESSAGE",
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
