const std = @import("std");

pub const KeywordInputType = enum {
    select_from_list,
    upload_file,
    input_text,

    pub const json_field_names = .{
        .select_from_list = "SELECT_FROM_LIST",
        .upload_file = "UPLOAD_FILE",
        .input_text = "INPUT_TEXT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .select_from_list => "SELECT_FROM_LIST",
            .upload_file => "UPLOAD_FILE",
            .input_text => "INPUT_TEXT",
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
