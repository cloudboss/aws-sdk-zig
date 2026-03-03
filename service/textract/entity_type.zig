const std = @import("std");

pub const EntityType = enum {
    key,
    value,
    column_header,
    table_title,
    table_footer,
    table_section_title,
    table_summary,
    structured_table,
    semi_structured_table,

    pub const json_field_names = .{
        .key = "KEY",
        .value = "VALUE",
        .column_header = "COLUMN_HEADER",
        .table_title = "TABLE_TITLE",
        .table_footer = "TABLE_FOOTER",
        .table_section_title = "TABLE_SECTION_TITLE",
        .table_summary = "TABLE_SUMMARY",
        .structured_table = "STRUCTURED_TABLE",
        .semi_structured_table = "SEMI_STRUCTURED_TABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .key => "KEY",
            .value => "VALUE",
            .column_header => "COLUMN_HEADER",
            .table_title => "TABLE_TITLE",
            .table_footer => "TABLE_FOOTER",
            .table_section_title => "TABLE_SECTION_TITLE",
            .table_summary => "TABLE_SUMMARY",
            .structured_table => "STRUCTURED_TABLE",
            .semi_structured_table => "SEMI_STRUCTURED_TABLE",
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
