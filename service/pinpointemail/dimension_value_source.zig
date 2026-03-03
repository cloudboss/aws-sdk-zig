const std = @import("std");

/// The location where Amazon Pinpoint finds the value of a dimension to publish
/// to Amazon CloudWatch. If you
/// want Amazon Pinpoint to use the message tags that you specify using an
/// X-SES-MESSAGE-TAGS header
/// or a parameter to the SendEmail/SendRawEmail API, choose `messageTag`. If
/// you
/// want Amazon Pinpoint to use your own email headers, choose `emailHeader`. If
/// you want
/// Amazon Pinpoint to use link tags, choose `linkTags`.
pub const DimensionValueSource = enum {
    message_tag,
    email_header,
    link_tag,

    pub const json_field_names = .{
        .message_tag = "MESSAGE_TAG",
        .email_header = "EMAIL_HEADER",
        .link_tag = "LINK_TAG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .message_tag => "MESSAGE_TAG",
            .email_header => "EMAIL_HEADER",
            .link_tag => "LINK_TAG",
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
