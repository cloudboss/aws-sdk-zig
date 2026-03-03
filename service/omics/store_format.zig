const std = @import("std");

pub const StoreFormat = enum {
    /// GFF3 Format
    gff,
    /// TSV Format
    tsv,
    /// VCF Format
    vcf,

    pub const json_field_names = .{
        .gff = "GFF",
        .tsv = "TSV",
        .vcf = "VCF",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .gff => "GFF",
            .tsv => "TSV",
            .vcf => "VCF",
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
