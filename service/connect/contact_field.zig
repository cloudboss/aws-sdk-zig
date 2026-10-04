const std = @import("std");

pub const ContactField = enum {
    customer_endpoint,
    additional_email_recipients,
    email_subject,

    pub const json_field_names = .{
        .customer_endpoint = "CUSTOMER_ENDPOINT",
        .additional_email_recipients = "ADDITIONAL_EMAIL_RECIPIENTS",
        .email_subject = "EMAIL_SUBJECT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .customer_endpoint => "CUSTOMER_ENDPOINT",
            .additional_email_recipients => "ADDITIONAL_EMAIL_RECIPIENTS",
            .email_subject => "EMAIL_SUBJECT",
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
