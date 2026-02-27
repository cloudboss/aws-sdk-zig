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
};
