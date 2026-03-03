const std = @import("std");

pub const PiiType = enum {
    row_audit,
    row_hashing,
    row_masking,
    row_partial_masking,
    column_audit,
    column_hashing,
    column_masking,

    pub const json_field_names = .{
        .row_audit = "RowAudit",
        .row_hashing = "RowHashing",
        .row_masking = "RowMasking",
        .row_partial_masking = "RowPartialMasking",
        .column_audit = "ColumnAudit",
        .column_hashing = "ColumnHashing",
        .column_masking = "ColumnMasking",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .row_audit => "RowAudit",
            .row_hashing => "RowHashing",
            .row_masking => "RowMasking",
            .row_partial_masking => "RowPartialMasking",
            .column_audit => "ColumnAudit",
            .column_hashing => "ColumnHashing",
            .column_masking => "ColumnMasking",
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
