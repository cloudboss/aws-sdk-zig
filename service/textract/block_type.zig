const std = @import("std");

pub const BlockType = enum {
    key_value_set,
    page,
    line,
    word,
    table,
    cell,
    selection_element,
    merged_cell,
    title,
    query,
    query_result,
    signature,
    table_title,
    table_footer,
    layout_text,
    layout_title,
    layout_header,
    layout_footer,
    layout_section_header,
    layout_page_number,
    layout_list,
    layout_figure,
    layout_table,
    layout_key_value,

    pub const json_field_names = .{
        .key_value_set = "KEY_VALUE_SET",
        .page = "PAGE",
        .line = "LINE",
        .word = "WORD",
        .table = "TABLE",
        .cell = "CELL",
        .selection_element = "SELECTION_ELEMENT",
        .merged_cell = "MERGED_CELL",
        .title = "TITLE",
        .query = "QUERY",
        .query_result = "QUERY_RESULT",
        .signature = "SIGNATURE",
        .table_title = "TABLE_TITLE",
        .table_footer = "TABLE_FOOTER",
        .layout_text = "LAYOUT_TEXT",
        .layout_title = "LAYOUT_TITLE",
        .layout_header = "LAYOUT_HEADER",
        .layout_footer = "LAYOUT_FOOTER",
        .layout_section_header = "LAYOUT_SECTION_HEADER",
        .layout_page_number = "LAYOUT_PAGE_NUMBER",
        .layout_list = "LAYOUT_LIST",
        .layout_figure = "LAYOUT_FIGURE",
        .layout_table = "LAYOUT_TABLE",
        .layout_key_value = "LAYOUT_KEY_VALUE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .key_value_set => "KEY_VALUE_SET",
            .page => "PAGE",
            .line => "LINE",
            .word => "WORD",
            .table => "TABLE",
            .cell => "CELL",
            .selection_element => "SELECTION_ELEMENT",
            .merged_cell => "MERGED_CELL",
            .title => "TITLE",
            .query => "QUERY",
            .query_result => "QUERY_RESULT",
            .signature => "SIGNATURE",
            .table_title => "TABLE_TITLE",
            .table_footer => "TABLE_FOOTER",
            .layout_text => "LAYOUT_TEXT",
            .layout_title => "LAYOUT_TITLE",
            .layout_header => "LAYOUT_HEADER",
            .layout_footer => "LAYOUT_FOOTER",
            .layout_section_header => "LAYOUT_SECTION_HEADER",
            .layout_page_number => "LAYOUT_PAGE_NUMBER",
            .layout_list => "LAYOUT_LIST",
            .layout_figure => "LAYOUT_FIGURE",
            .layout_table => "LAYOUT_TABLE",
            .layout_key_value => "LAYOUT_KEY_VALUE",
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
