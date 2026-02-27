pub const ETagAlgorithm = enum {
    fastq_md5_up,
    bam_md5_up,
    cram_md5_up,
    fastq_sha256_up,
    bam_sha256_up,
    cram_sha256_up,
    fastq_sha512_up,
    bam_sha512_up,
    cram_sha512_up,

    pub const json_field_names = .{
        .fastq_md5_up = "FASTQ_MD5UP",
        .bam_md5_up = "BAM_MD5UP",
        .cram_md5_up = "CRAM_MD5UP",
        .fastq_sha256_up = "FASTQ_SHA256UP",
        .bam_sha256_up = "BAM_SHA256UP",
        .cram_sha256_up = "CRAM_SHA256UP",
        .fastq_sha512_up = "FASTQ_SHA512UP",
        .bam_sha512_up = "BAM_SHA512UP",
        .cram_sha512_up = "CRAM_SHA512UP",
    };
};
