pub const FileType = enum {
    fastq,
    bam,
    cram,
    ubam,

    pub const json_field_names = .{
        .fastq = "FASTQ",
        .bam = "BAM",
        .cram = "CRAM",
        .ubam = "UBAM",
    };
};
