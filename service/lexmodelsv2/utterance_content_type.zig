const std = @import("std");

pub const UtteranceContentType = enum {
    plain_text,
    custom_payload,
    ssml,
    image_response_card,

    pub const json_field_names = .{
        .plain_text = "PlainText",
        .custom_payload = "CustomPayload",
        .ssml = "SSML",
        .image_response_card = "ImageResponseCard",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .plain_text => "PlainText",
            .custom_payload => "CustomPayload",
            .ssml => "SSML",
            .image_response_card => "ImageResponseCard",
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
