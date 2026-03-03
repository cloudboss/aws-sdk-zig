const std = @import("std");

/// The action that you want Amazon Pinpoint to take if it can't read the
/// required MX record for a
/// custom MAIL FROM domain. When you set this value to `UseDefaultValue`,
/// Amazon Pinpoint
/// uses *amazonses.com* as the MAIL FROM domain. When you set this value
/// to `RejectMessage`, Amazon Pinpoint returns a `MailFromDomainNotVerified`
/// error, and doesn't attempt to deliver the email.
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
