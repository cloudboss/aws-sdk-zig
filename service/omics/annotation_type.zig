const std = @import("std");

pub const AnnotationType = enum {
    /// Generic text file. No genomic information
    generic,
    /// Contains contig and 1-base position
    chr_pos,
    /// Contains contig, 1-base position, ref and alt allele information
    chr_pos_ref_alt,
    /// Contains contig, start, and end positions. Coordinates are 1-based
    chr_start_end_one_base,
    /// Contains contig, start, end, ref and alt allele information. Coordinates are
    /// 1-based
    chr_start_end_ref_alt_one_base,
    /// Contains contig, start, and end positions. Coordinates are 0-based
    chr_start_end_zero_base,
    /// Contains contig, start, end, ref and alt allele information. Coordinates are
    /// 0-based
    chr_start_end_ref_alt_zero_base,

    pub const json_field_names = .{
        .generic = "GENERIC",
        .chr_pos = "CHR_POS",
        .chr_pos_ref_alt = "CHR_POS_REF_ALT",
        .chr_start_end_one_base = "CHR_START_END_ONE_BASE",
        .chr_start_end_ref_alt_one_base = "CHR_START_END_REF_ALT_ONE_BASE",
        .chr_start_end_zero_base = "CHR_START_END_ZERO_BASE",
        .chr_start_end_ref_alt_zero_base = "CHR_START_END_REF_ALT_ZERO_BASE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .generic => "GENERIC",
            .chr_pos => "CHR_POS",
            .chr_pos_ref_alt => "CHR_POS_REF_ALT",
            .chr_start_end_one_base => "CHR_START_END_ONE_BASE",
            .chr_start_end_ref_alt_one_base => "CHR_START_END_REF_ALT_ONE_BASE",
            .chr_start_end_zero_base => "CHR_START_END_ZERO_BASE",
            .chr_start_end_ref_alt_zero_base => "CHR_START_END_REF_ALT_ZERO_BASE",
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
