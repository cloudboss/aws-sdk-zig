const std = @import("std");

pub const DefaultDocumentIdFormat = enum {
    firehose_default,
    no_document_id,

    pub const json_field_names = .{
        .firehose_default = "FIREHOSE_DEFAULT",
        .no_document_id = "NO_DOCUMENT_ID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .firehose_default => "FIREHOSE_DEFAULT",
            .no_document_id => "NO_DOCUMENT_ID",
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
