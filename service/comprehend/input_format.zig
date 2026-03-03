const std = @import("std");

pub const InputFormat = enum {
    one_doc_per_file,
    one_doc_per_line,

    pub const json_field_names = .{
        .one_doc_per_file = "ONE_DOC_PER_FILE",
        .one_doc_per_line = "ONE_DOC_PER_LINE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .one_doc_per_file => "ONE_DOC_PER_FILE",
            .one_doc_per_line => "ONE_DOC_PER_LINE",
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
