pub const VcfVersion = enum {
    vcf_5_2_1,
    vcf_5_2_2,

    pub const json_field_names = .{
        .vcf_5_2_1 = "VCF_5_2_1",
        .vcf_5_2_2 = "VCF_5_2_2",
    };
};
