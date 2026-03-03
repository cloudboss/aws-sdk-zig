const std = @import("std");

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
        .fastq_md5_up = "FASTQ_MD5up",
        .bam_md5_up = "BAM_MD5up",
        .cram_md5_up = "CRAM_MD5up",
        .fastq_sha256_up = "FASTQ_SHA256up",
        .bam_sha256_up = "BAM_SHA256up",
        .cram_sha256_up = "CRAM_SHA256up",
        .fastq_sha512_up = "FASTQ_SHA512up",
        .bam_sha512_up = "BAM_SHA512up",
        .cram_sha512_up = "CRAM_SHA512up",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fastq_md5_up => "FASTQ_MD5up",
            .bam_md5_up => "BAM_MD5up",
            .cram_md5_up => "CRAM_MD5up",
            .fastq_sha256_up => "FASTQ_SHA256up",
            .bam_sha256_up => "BAM_SHA256up",
            .cram_sha256_up => "CRAM_SHA256up",
            .fastq_sha512_up => "FASTQ_SHA512up",
            .bam_sha512_up => "BAM_SHA512up",
            .cram_sha512_up => "CRAM_SHA512up",
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
