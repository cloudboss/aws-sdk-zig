const std = @import("std");

pub const ThreatIntelIndicatorType = enum {
    domain,
    email_address,
    hash_md5,
    hash_sha1,
    hash_sha256,
    hash_sha512,
    ipv4_address,
    ipv6_address,
    mutex,
    process,
    url,

    pub const json_field_names = .{
        .domain = "DOMAIN",
        .email_address = "EMAIL_ADDRESS",
        .hash_md5 = "HASH_MD5",
        .hash_sha1 = "HASH_SHA1",
        .hash_sha256 = "HASH_SHA256",
        .hash_sha512 = "HASH_SHA512",
        .ipv4_address = "IPV4_ADDRESS",
        .ipv6_address = "IPV6_ADDRESS",
        .mutex = "MUTEX",
        .process = "PROCESS",
        .url = "URL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .domain => "DOMAIN",
            .email_address => "EMAIL_ADDRESS",
            .hash_md5 => "HASH_MD5",
            .hash_sha1 => "HASH_SHA1",
            .hash_sha256 => "HASH_SHA256",
            .hash_sha512 => "HASH_SHA512",
            .ipv4_address => "IPV4_ADDRESS",
            .ipv6_address => "IPV6_ADDRESS",
            .mutex => "MUTEX",
            .process => "PROCESS",
            .url => "URL",
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
