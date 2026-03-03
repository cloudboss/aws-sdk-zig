const std = @import("std");

pub const PageBasedErrorCode = enum {
    textract_bad_page,
    textract_provisioned_throughput_exceeded,
    page_characters_exceeded,
    page_size_exceeded,
    internal_server_error,

    pub const json_field_names = .{
        .textract_bad_page = "TEXTRACT_BAD_PAGE",
        .textract_provisioned_throughput_exceeded = "TEXTRACT_PROVISIONED_THROUGHPUT_EXCEEDED",
        .page_characters_exceeded = "PAGE_CHARACTERS_EXCEEDED",
        .page_size_exceeded = "PAGE_SIZE_EXCEEDED",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .textract_bad_page => "TEXTRACT_BAD_PAGE",
            .textract_provisioned_throughput_exceeded => "TEXTRACT_PROVISIONED_THROUGHPUT_EXCEEDED",
            .page_characters_exceeded => "PAGE_CHARACTERS_EXCEEDED",
            .page_size_exceeded => "PAGE_SIZE_EXCEEDED",
            .internal_server_error => "INTERNAL_SERVER_ERROR",
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
