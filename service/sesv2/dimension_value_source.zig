const std = @import("std");

/// The location where the Amazon SES API v2 finds the value of a dimension to
/// publish to Amazon CloudWatch. To
/// use the message tags that you specify using an `X-SES-MESSAGE-TAGS` header
/// or
/// a parameter to the `SendEmail` or `SendRawEmail` API, choose
/// `messageTag`. To use your own email headers, choose
/// `emailHeader`. To use link tags, choose `linkTags`.
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
