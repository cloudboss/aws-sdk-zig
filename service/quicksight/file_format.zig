const std = @import("std");

pub const FileFormat = enum {
    csv,
    tsv,
    clf,
    elf,
    xlsx,
    json,

    pub const json_field_names = .{
        .csv = "CSV",
        .tsv = "TSV",
        .clf = "CLF",
        .elf = "ELF",
        .xlsx = "XLSX",
        .json = "JSON",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .csv => "CSV",
            .tsv => "TSV",
            .clf => "CLF",
            .elf => "ELF",
            .xlsx => "XLSX",
            .json => "JSON",
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
