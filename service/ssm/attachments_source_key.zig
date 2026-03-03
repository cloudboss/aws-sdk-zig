const std = @import("std");

pub const AttachmentsSourceKey = enum {
    source_url,
    s3_file_url,
    attachment_reference,

    pub const json_field_names = .{
        .source_url = "SourceUrl",
        .s3_file_url = "S3FileUrl",
        .attachment_reference = "AttachmentReference",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .source_url => "SourceUrl",
            .s3_file_url => "S3FileUrl",
            .attachment_reference => "AttachmentReference",
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
