//! Flexible checksum computation for AWS request/response integrity.
//!
//! Supports CRC32, CRC32C (Castagnoli), SHA256, and SHA1 with
//! base64-encoded output suitable for AWS checksum headers.

const std = @import("std");
const Allocator = std.mem.Allocator;

pub const Algorithm = enum {
    crc32,
    crc32c,
    sha256,
    sha1,
};

pub fn computeCrc32(data: []const u8) u32 {
    return std.hash.crc.Crc32IsoHdlc.hash(data);
}

pub fn computeCrc32c(data: []const u8) u32 {
    return std.hash.crc.Crc32Iscsi.hash(data);
}

pub fn computeSha256(
    data: []const u8,
    out: *[32]u8,
) void {
    std.crypto.hash.sha2.Sha256.hash(data, out, .{});
}

pub fn computeSha1(data: []const u8, out: *[20]u8) void {
    std.crypto.hash.Sha1.hash(data, out, .{});
}

/// Compute the checksum of `data` using `algorithm` and return
/// it as a base64-encoded string. Caller owns the returned slice.
pub fn computeBase64(
    allocator: Allocator,
    algorithm: Algorithm,
    data: []const u8,
) ![]const u8 {
    const Encoder = std.base64.standard.Encoder;
    switch (algorithm) {
        .crc32, .crc32c => {
            const value: u32 = switch (algorithm) {
                .crc32 => computeCrc32(data),
                .crc32c => computeCrc32c(data),
                else => unreachable,
            };
            var bytes: [4]u8 = undefined;
            std.mem.writeInt(u32, &bytes, value, .big);
            const size = Encoder.calcSize(4);
            const buf = try allocator.alloc(u8, size);
            _ = Encoder.encode(buf, &bytes);
            return buf;
        },
        .sha256 => {
            var digest: [32]u8 = undefined;
            computeSha256(data, &digest);
            const size = Encoder.calcSize(32);
            const buf = try allocator.alloc(u8, size);
            _ = Encoder.encode(buf, &digest);
            return buf;
        },
        .sha1 => {
            var digest: [20]u8 = undefined;
            computeSha1(data, &digest);
            const size = Encoder.calcSize(20);
            const buf = try allocator.alloc(u8, size);
            _ = Encoder.encode(buf, &digest);
            return buf;
        },
    }
}

/// Compute the checksum of `data` and compare the base64-encoded
/// result against `expected_base64`. Returns true if they match.
pub fn verify(
    algorithm: Algorithm,
    data: []const u8,
    expected_base64: []const u8,
    allocator: Allocator,
) !bool {
    const computed = try computeBase64(
        allocator,
        algorithm,
        data,
    );
    defer allocator.free(computed);
    return std.mem.eql(u8, computed, expected_base64);
}

// -- Tests ----------------------------------------------------------

const testing = std.testing;

test "CRC32 of '123456789'" {
    const result = computeCrc32("123456789");
    try testing.expectEqual(@as(u32, 0xCBF43926), result);
}

test "CRC32 of empty string" {
    const result = computeCrc32("");
    try testing.expectEqual(@as(u32, 0x00000000), result);
}

test "CRC32C of '123456789'" {
    const result = computeCrc32c("123456789");
    try testing.expectEqual(@as(u32, 0xE3069283), result);
}

test "SHA256 of empty string" {
    var digest: [32]u8 = undefined;
    computeSha256("", &digest);
    const hex = std.fmt.bytesToHex(&digest, .lower);
    try testing.expectEqualStrings(
        "e3b0c44298fc1c149afbf4c8996fb924" ++
            "27ae41e4649b934ca495991b7852b855",
        &hex,
    );
}

test "SHA256 of 'abc'" {
    var digest: [32]u8 = undefined;
    computeSha256("abc", &digest);
    const hex = std.fmt.bytesToHex(&digest, .lower);
    try testing.expectEqualStrings(
        "ba7816bf8f01cfea414140de5dae2223" ++
            "b00361a396177a9cb410ff61f20015ad",
        &hex,
    );
}

test "SHA1 produces 20-byte digest" {
    var digest: [20]u8 = undefined;
    computeSha1("abc", &digest);
    const hex = std.fmt.bytesToHex(&digest, .lower);
    try testing.expectEqualStrings(
        "a9993e364706816aba3e25717850c26c9cd0d89d",
        &hex,
    );
}

test "base64 of CRC32('123456789')" {
    const b64 = try computeBase64(
        testing.allocator,
        .crc32,
        "123456789",
    );
    defer testing.allocator.free(b64);
    try testing.expectEqualStrings("y/Q5Jg==", b64);
}

test "base64 of CRC32C('123456789')" {
    const b64 = try computeBase64(
        testing.allocator,
        .crc32c,
        "123456789",
    );
    defer testing.allocator.free(b64);
    // 0xE3069283 big-endian = [0xE3, 0x06, 0x92, 0x83]
    try testing.expectEqualStrings("4waSgw==", b64);
}

test "base64 of SHA256('')" {
    const b64 = try computeBase64(
        testing.allocator,
        .sha256,
        "",
    );
    defer testing.allocator.free(b64);
    try testing.expectEqualStrings(
        "47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=",
        b64,
    );
}

test "verify returns true for matching checksum" {
    const ok = try verify(
        .crc32,
        "123456789",
        "y/Q5Jg==",
        testing.allocator,
    );
    try testing.expect(ok);
}

test "verify returns false for mismatched checksum" {
    const ok = try verify(
        .crc32,
        "123456789",
        "AAAA",
        testing.allocator,
    );
    try testing.expect(!ok);
}
