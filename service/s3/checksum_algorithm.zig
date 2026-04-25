const std = @import("std");

pub const ChecksumAlgorithm = enum {
    crc32,
    crc32_c,
    sha1,
    sha256,
    crc64_nvme,
    sha512,
    md5,
    xxhash64,
    xxhash3,
    xxhash128,

    pub const json_field_names = .{
        .crc32 = "CRC32",
        .crc32_c = "CRC32C",
        .sha1 = "SHA1",
        .sha256 = "SHA256",
        .crc64_nvme = "CRC64NVME",
        .sha512 = "SHA512",
        .md5 = "MD5",
        .xxhash64 = "XXHASH64",
        .xxhash3 = "XXHASH3",
        .xxhash128 = "XXHASH128",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .crc32 => "CRC32",
            .crc32_c => "CRC32C",
            .sha1 => "SHA1",
            .sha256 => "SHA256",
            .crc64_nvme => "CRC64NVME",
            .sha512 => "SHA512",
            .md5 => "MD5",
            .xxhash64 => "XXHASH64",
            .xxhash3 => "XXHASH3",
            .xxhash128 => "XXHASH128",
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
