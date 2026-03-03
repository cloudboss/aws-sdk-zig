const std = @import("std");

pub const ComputeObjectChecksumAlgorithm = enum {
    crc32,
    crc32_c,
    crc64_nvme,
    md5,
    sha1,
    sha256,

    pub const json_field_names = .{
        .crc32 = "CRC32",
        .crc32_c = "CRC32C",
        .crc64_nvme = "CRC64NVME",
        .md5 = "MD5",
        .sha1 = "SHA1",
        .sha256 = "SHA256",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .crc32 => "CRC32",
            .crc32_c => "CRC32C",
            .crc64_nvme => "CRC64NVME",
            .md5 => "MD5",
            .sha1 => "SHA1",
            .sha256 => "SHA256",
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
