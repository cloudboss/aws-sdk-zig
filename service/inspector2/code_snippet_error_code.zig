const std = @import("std");

pub const CodeSnippetErrorCode = enum {
    internal_error,
    access_denied,
    code_snippet_not_found,
    invalid_input,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .access_denied = "ACCESS_DENIED",
        .code_snippet_not_found = "CODE_SNIPPET_NOT_FOUND",
        .invalid_input = "INVALID_INPUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_error => "INTERNAL_ERROR",
            .access_denied => "ACCESS_DENIED",
            .code_snippet_not_found => "CODE_SNIPPET_NOT_FOUND",
            .invalid_input => "INVALID_INPUT",
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
