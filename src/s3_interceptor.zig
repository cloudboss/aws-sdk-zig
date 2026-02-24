const std = @import("std");

const checksum_mod = @import("checksum.zig");
const http = @import("http.zig");

const log = std.log.scoped(.aws_sdk);

pub const S3ChecksumInterceptor = struct {
    pub fn interceptor() http.Interceptor {
        return .{ .pre_send = preSend, .post_receive = postReceive };
    }

    fn preSend(request: *const http.Request) void {
        _ = request;
    }

    fn postReceive(response: *const http.Response) void {
        const alg_headers = [_]struct {
            alg: checksum_mod.Algorithm,
            header: []const u8,
        }{
            .{ .alg = .crc32, .header = "x-amz-checksum-crc32" },
            .{ .alg = .crc32c, .header = "x-amz-checksum-crc32c" },
            .{ .alg = .sha256, .header = "x-amz-checksum-sha256" },
            .{ .alg = .sha1, .header = "x-amz-checksum-sha1" },
        };
        for (alg_headers) |entry| {
            if (response.headers.get(entry.header)) |expected| {
                const ok = checksum_mod.verify(
                    entry.alg,
                    response.body,
                    expected,
                    response.allocator,
                ) catch false;
                if (!ok) {
                    log.warn(
                        "S3 response checksum mismatch for {s}",
                        .{entry.header},
                    );
                }
                break;
            }
        }
    }
};

fn makeResponse(
    allocator: std.mem.Allocator,
    body: []const u8,
    header_name: []const u8,
    header_value: []const u8,
) !http.Response {
    var headers = std.StringHashMapUnmanaged([]const u8){};
    const key = try allocator.dupe(u8, header_name);
    errdefer allocator.free(key);
    const value = try allocator.dupe(u8, header_value);
    errdefer allocator.free(value);
    try headers.put(allocator, key, value);
    const body_copy = try allocator.dupe(u8, body);
    return http.Response{
        .status = 200,
        .body = body_copy,
        .headers = headers,
        .allocator = allocator,
    };
}

test "post_receive validates CRC32 header" {
    const payload = "test";
    const b64 = try checksum_mod.computeBase64(
        std.testing.allocator,
        .crc32,
        payload,
    );
    defer std.testing.allocator.free(b64);

    var response = try makeResponse(
        std.testing.allocator,
        payload,
        "x-amz-checksum-crc32",
        b64,
    );
    defer response.deinit();

    S3ChecksumInterceptor.postReceive(&response);
}

test "post_receive logs warning for mismatched checksum" {
    const payload = "test";
    var response = try makeResponse(
        std.testing.allocator,
        payload,
        "x-amz-checksum-crc32",
        "AAAA",
    );
    defer response.deinit();

    const ok = try checksum_mod.verify(
        .crc32,
        payload,
        "AAAA",
        std.testing.allocator,
    );
    try std.testing.expect(!ok);

    S3ChecksumInterceptor.postReceive(&response);
}

test "interceptor returns a configured http.Interceptor" {
    const ic = S3ChecksumInterceptor.interceptor();
    try std.testing.expect(ic.pre_send != null);
    try std.testing.expect(ic.post_receive != null);
}
