const std = @import("std");

pub const AmazonOpenSearchServerlessS3BackupMode = enum {
    failed_documents_only,
    all_documents,

    pub const json_field_names = .{
        .failed_documents_only = "FailedDocumentsOnly",
        .all_documents = "AllDocuments",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .failed_documents_only => "FailedDocumentsOnly",
            .all_documents => "AllDocuments",
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
