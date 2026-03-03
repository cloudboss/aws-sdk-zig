const std = @import("std");

pub const MessageContentType = enum {
    custom_payload,
    image_response_card,
    plain_text,
    ssml,

    pub const json_field_names = .{
        .custom_payload = "CustomPayload",
        .image_response_card = "ImageResponseCard",
        .plain_text = "PlainText",
        .ssml = "SSML",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .custom_payload => "CustomPayload",
            .image_response_card => "ImageResponseCard",
            .plain_text => "PlainText",
            .ssml => "SSML",
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
