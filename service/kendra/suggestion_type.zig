const std = @import("std");

pub const SuggestionType = enum {
    query,
    document_attributes,

    pub const json_field_names = .{
        .query = "QUERY",
        .document_attributes = "DOCUMENT_ATTRIBUTES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .query => "QUERY",
            .document_attributes => "DOCUMENT_ATTRIBUTES",
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
