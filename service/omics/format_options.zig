const TsvOptions = @import("tsv_options.zig").TsvOptions;
const VcfOptions = @import("vcf_options.zig").VcfOptions;

/// Formatting options for a file.
pub const FormatOptions = union(enum) {
    /// Options for a TSV file.
    tsv_options: ?TsvOptions,
    /// Options for a VCF file.
    vcf_options: ?VcfOptions,

    pub const json_field_names = .{
        .tsv_options = "tsvOptions",
        .vcf_options = "vcfOptions",
    };
};
