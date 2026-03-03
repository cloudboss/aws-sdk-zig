const std = @import("std");

pub const RelationshipType = enum {
    value,
    child,
    complex_features,
    merged_cell,
    title,
    answer,
    table,
    table_title,
    table_footer,

    pub const json_field_names = .{
        .value = "VALUE",
        .child = "CHILD",
        .complex_features = "COMPLEX_FEATURES",
        .merged_cell = "MERGED_CELL",
        .title = "TITLE",
        .answer = "ANSWER",
        .table = "TABLE",
        .table_title = "TABLE_TITLE",
        .table_footer = "TABLE_FOOTER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .value => "VALUE",
            .child => "CHILD",
            .complex_features => "COMPLEX_FEATURES",
            .merged_cell => "MERGED_CELL",
            .title => "TITLE",
            .answer => "ANSWER",
            .table => "TABLE",
            .table_title => "TABLE_TITLE",
            .table_footer => "TABLE_FOOTER",
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
