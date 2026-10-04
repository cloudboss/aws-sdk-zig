const std = @import("std");

pub const CardType = enum {
    text_input,
    q_query,
    file_upload,
    q_plugin,
    form_input,

    pub const json_field_names = .{
        .text_input = "text-input",
        .q_query = "q-query",
        .file_upload = "file-upload",
        .q_plugin = "q-plugin",
        .form_input = "form-input",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .text_input => "text-input",
            .q_query => "q-query",
            .file_upload => "file-upload",
            .q_plugin => "q-plugin",
            .form_input => "form-input",
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
