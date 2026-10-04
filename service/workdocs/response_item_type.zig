const std = @import("std");

pub const ResponseItemType = enum {
    document,
    folder,
    comment,
    document_version,

    pub const json_field_names = .{
        .document = "DOCUMENT",
        .folder = "FOLDER",
        .comment = "COMMENT",
        .document_version = "DOCUMENT_VERSION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .document => "DOCUMENT",
            .folder => "FOLDER",
            .comment => "COMMENT",
            .document_version => "DOCUMENT_VERSION",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
