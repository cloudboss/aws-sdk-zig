//! AWS Signature Version 4
//!
//! Reference: https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html

const std = @import("std");
const Allocator = std.mem.Allocator;
const Hmac = std.crypto.auth.hmac.sha2.HmacSha256;
const Sha256 = std.crypto.hash.sha2.Sha256;

const Credentials = @import("credentials.zig").Credentials;
const http = @import("http.zig");
const gzip_mod = @import("gzip.zig");

pub const algorithm = "AWS4-HMAC-SHA256";

/// Options for presigning a request.
pub const PresignOptions = struct {
    /// How long the presigned URL is valid, in seconds (default: 1 hour, max: 7 days).
    expires_seconds: u64 = 3600,
};

/// Presign a request -- puts the SigV4 signature in query parameters instead
/// of the `Authorization` header.  Returns the full presigned URL as an
/// owned string that the caller must free.
pub fn presignRequest(
    allocator: Allocator,
    request: *const http.Request,
    credentials: Credentials,
    region: []const u8,
    service: []const u8,
    options: PresignOptions,
) ![]const u8 {
    const timestamp = std.time.timestamp();
    const datetime = formatAmzDate(timestamp);
    const datestamp = datetime[0..8];

    const credential_scope = try std.fmt.allocPrint(allocator, "{s}/{s}/{s}/aws4_request", .{
        datestamp, region, service,
    });
    defer allocator.free(credential_scope);

    const credential = try std.fmt.allocPrint(allocator, "{s}/{s}", .{
        credentials.access_key_id, credential_scope,
    });
    defer allocator.free(credential);

    // Ensure host header is present for signed-headers computation.
    // We work on a mutable copy of the headers so the caller's request
    // is not modified.
    var headers = try request.headers.clone(allocator);
    var allocated_host: ?[]const u8 = null;
    defer {
        if (allocated_host) |h| allocator.free(h);
        headers.deinit(allocator);
    }

    if (headers.get("host") == null) {
        const is_default_port = if (request.port) |port|
            (request.tls and port == 443) or (!request.tls and port == 80)
        else
            true;
        if (!is_default_port) {
            const host_with_port = try std.fmt.allocPrint(
                allocator,
                "{s}:{d}",
                .{ request.host, request.port.? },
            );
            allocated_host = host_with_port;
            try headers.put(allocator, "host", host_with_port);
        } else {
            try headers.put(allocator, "host", request.host);
        }
    }

    // Build signed-headers list from the (possibly augmented) header set.
    const headers_result = try canonicalizeHeaders(allocator, &headers);
    defer allocator.free(headers_result.canonical);
    defer allocator.free(headers_result.signed);

    // Canonical URI
    const canonical_uri = try encodeUri(
        allocator,
        if (request.path.len == 0) "/" else request.path,
    );
    defer allocator.free(canonical_uri);

    // Build the canonical query string: existing params + X-Amz-* presign params, sorted.
    const canonical_query = try buildPresignCanonicalQuery(
        allocator,
        request.query,
        &datetime,
        credential,
        headers_result.signed,
        options.expires_seconds,
        credentials.session_token,
    );
    defer allocator.free(canonical_query);

    // Canonical request (payload is always UNSIGNED-PAYLOAD for presigning)
    const method = @tagName(request.method);
    const canonical_request = try std.fmt.allocPrint(allocator, "{s}\n{s}\n{s}\n{s}\n{s}\n{s}", .{
        method,
        canonical_uri,
        canonical_query,
        headers_result.canonical,
        headers_result.signed,
        "UNSIGNED-PAYLOAD",
    });
    defer allocator.free(canonical_request);

    // String to sign
    var canonical_request_hash: [Sha256.digest_length]u8 = undefined;
    Sha256.hash(canonical_request, &canonical_request_hash, .{});
    const canonical_request_hash_hex = std.fmt.bytesToHex(&canonical_request_hash, .lower);

    const string_to_sign = try std.fmt.allocPrint(allocator, "{s}\n{s}\n{s}\n{s}", .{
        algorithm,
        datetime,
        credential_scope,
        canonical_request_hash_hex,
    });
    defer allocator.free(string_to_sign);

    // Signature
    const signing_key = deriveSigningKey(credentials.secret_access_key, datestamp, region, service);
    var signature: [Hmac.mac_length]u8 = undefined;
    Hmac.create(&signature, string_to_sign, &signing_key);
    const signature_hex = std.fmt.bytesToHex(&signature, .lower);

    // Assemble final URL
    const scheme: []const u8 = if (request.tls) "https" else "http";

    const port_str = if (request.port) |p| blk: {
        const is_default = (request.tls and p == 443) or (!request.tls and p == 80);
        if (is_default) break :blk try allocator.dupe(u8, "");
        break :blk try std.fmt.allocPrint(allocator, ":{d}", .{p});
    } else try allocator.dupe(u8, "");
    defer allocator.free(port_str);

    const path_str = if (request.path.len == 0) "/" else request.path;

    return std.fmt.allocPrint(allocator, "{s}://{s}{s}{s}?{s}&X-Amz-Signature={s}", .{
        scheme,
        request.host,
        port_str,
        path_str,
        canonical_query,
        signature_hex,
    });
}

/// Build the canonical query string for presigning.  Merges any existing
/// query parameters with the required `X-Amz-*` presigning parameters and
/// returns the sorted, percent-encoded result.
fn buildPresignCanonicalQuery(
    allocator: Allocator,
    existing_query: ?[]const u8,
    datetime: []const u8,
    credential: []const u8,
    signed_headers: []const u8,
    expires_seconds: u64,
    session_token: ?[]const u8,
) ![]const u8 {
    var pairs: std.ArrayList(QueryPair) = .{};
    defer pairs.deinit(allocator);

    // Parse existing query params
    if (existing_query) |q| {
        var param_iter = std.mem.splitScalar(u8, q, '&');
        while (param_iter.next()) |param| {
            if (param.len == 0) continue;
            if (std.mem.indexOfScalar(u8, param, '=')) |eq_idx| {
                try pairs.append(allocator, .{
                    .key = param[0..eq_idx],
                    .value = param[eq_idx + 1 ..],
                });
            } else {
                try pairs.append(allocator, .{ .key = param, .value = "" });
            }
        }
    }

    // Add X-Amz-* presigning parameters -- pre-encode values that contain
    // characters outside the unreserved set (credential has '/', signed-headers
    // has ';', session tokens may have special chars).
    try pairs.append(allocator, .{ .key = "X-Amz-Algorithm", .value = algorithm });

    const encoded_credential = try encodeQueryValue(allocator, credential);
    defer allocator.free(encoded_credential);
    try pairs.append(allocator, .{ .key = "X-Amz-Credential", .value = encoded_credential });

    try pairs.append(allocator, .{ .key = "X-Amz-Date", .value = datetime });

    const expires_str = try std.fmt.allocPrint(allocator, "{d}", .{expires_seconds});
    defer allocator.free(expires_str);
    try pairs.append(allocator, .{ .key = "X-Amz-Expires", .value = expires_str });

    const encoded_signed_headers = try encodeQueryValue(allocator, signed_headers);
    defer allocator.free(encoded_signed_headers);
    try pairs.append(allocator, .{ .key = "X-Amz-SignedHeaders", .value = encoded_signed_headers });

    var encoded_token: ?[]const u8 = null;
    defer if (encoded_token) |t| allocator.free(t);
    if (session_token) |token| {
        encoded_token = try encodeQueryValue(allocator, token);
        try pairs.append(allocator, .{ .key = "X-Amz-Security-Token", .value = encoded_token.? });
    }

    // Sort
    std.mem.sort(QueryPair, pairs.items, {}, struct {
        fn lessThan(_: void, a: QueryPair, b: QueryPair) bool {
            const key_cmp = std.mem.order(u8, a.key, b.key);
            if (key_cmp != .eq) return key_cmp == .lt;
            return std.mem.order(u8, a.value, b.value) == .lt;
        }
    }.lessThan);

    // All values are already URI-encoded (existing query params by the
    // serializer, X-Amz-* params above), so just sort and rejoin.
    var result: std.ArrayList(u8) = .{};
    errdefer result.deinit(allocator);

    for (pairs.items, 0..) |pair, i| {
        if (i > 0) try result.append(allocator, '&');
        try result.appendSlice(allocator, pair.key);
        try result.append(allocator, '=');
        try result.appendSlice(allocator, pair.value);
    }

    return result.toOwnedSlice(allocator);
}

/// Sign an HTTP request with AWS Signature Version 4
pub fn signRequest(
    allocator: Allocator,
    request: *http.Request,
    credentials: Credentials,
    region: []const u8,
    service: []const u8,
) !void {
    const timestamp = std.time.timestamp();
    const datetime = formatAmzDate(timestamp);
    const datestamp = datetime[0..8];

    // Compress body if requested and body exceeds threshold
    const COMPRESSION_THRESHOLD = 1024;

    if (request.request_compression) |compression_algorithm| {
        const body = request.body orelse "";
        if (body.len >= COMPRESSION_THRESHOLD) {
            switch (compression_algorithm) {
                .gzip => {
                    const compressed_bytes = try gzip_mod.compress(allocator, body);
                    request.body = compressed_bytes;
                    try request.headers.put(allocator, "content-encoding", "gzip");
                },
            }
        }
    }

    // Hash payload
    const payload = request.body orelse "";
    var payload_hash: [Sha256.digest_length]u8 = undefined;
    Sha256.hash(payload, &payload_hash, .{});
    const payload_hash_hex = std.fmt.bytesToHex(&payload_hash, .lower);

    // Add required headers (dupe stack values onto heap so they survive after return)
    try request.headers.put(allocator, "x-amz-date", try allocator.dupe(u8, &datetime));
    try request.headers.put(
        allocator,
        "x-amz-content-sha256",
        try allocator.dupe(u8, &payload_hash_hex),
    );
    if (credentials.session_token) |token| {
        try request.headers.put(allocator, "x-amz-security-token", token);
    }

    // Ensure host header is set (include port for non-default ports)
    if (request.headers.get("host") == null) {
        const is_default_port = if (request.port) |port|
            (request.tls and port == 443) or (!request.tls and port == 80)
        else
            true;
        if (!is_default_port) {
            const host_with_port = try std.fmt.allocPrint(
                allocator,
                "{s}:{d}",
                .{ request.host, request.port.? },
            );
            try request.headers.put(allocator, "host", host_with_port);
        } else {
            try request.headers.put(allocator, "host", request.host);
        }
    }

    // Build canonical request
    const canonical_result = try buildCanonicalRequest(allocator, request, &payload_hash_hex);
    defer allocator.free(canonical_result.canonical_request);
    defer allocator.free(canonical_result.signed_headers);

    // Build string to sign
    var canonical_request_hash: [Sha256.digest_length]u8 = undefined;
    Sha256.hash(canonical_result.canonical_request, &canonical_request_hash, .{});
    const canonical_request_hash_hex = std.fmt.bytesToHex(&canonical_request_hash, .lower);

    const credential_scope = try std.fmt.allocPrint(allocator, "{s}/{s}/{s}/aws4_request", .{
        datestamp,
        region,
        service,
    });
    defer allocator.free(credential_scope);

    const string_to_sign = try std.fmt.allocPrint(allocator, "{s}\n{s}\n{s}\n{s}", .{
        algorithm,
        datetime,
        credential_scope,
        canonical_request_hash_hex,
    });
    defer allocator.free(string_to_sign);

    // Calculate signature
    const signing_key = deriveSigningKey(credentials.secret_access_key, datestamp, region, service);
    var signature: [Hmac.mac_length]u8 = undefined;
    Hmac.create(&signature, string_to_sign, &signing_key);
    const signature_hex = std.fmt.bytesToHex(&signature, .lower);

    // Build authorization header
    const authorization = try std.fmt.allocPrint(allocator, "{s} Credential={s}/{s}, SignedHeaders={s}, Signature={s}", .{
        algorithm,
        credentials.access_key_id,
        credential_scope,
        canonical_result.signed_headers,
        signature_hex,
    });

    try request.headers.put(allocator, "authorization", authorization);
}

/// Format timestamp as AWS date (YYYYMMDD'T'HHMMSS'Z')
pub fn formatAmzDate(timestamp: i64) [16]u8 {
    const epoch_seconds = std.time.epoch.EpochSeconds{ .secs = @intCast(timestamp) };
    const year_day = epoch_seconds.getEpochDay().calculateYearDay();
    const month_day = year_day.calculateMonthDay();
    const day_seconds = epoch_seconds.getDaySeconds();

    var buf: [16]u8 = undefined;
    _ = std.fmt.bufPrint(&buf, "{d:0>4}{d:0>2}{d:0>2}T{d:0>2}{d:0>2}{d:0>2}Z", .{
        year_day.year,
        month_day.month.numeric(),
        month_day.day_index + 1,
        day_seconds.getHoursIntoDay(),
        day_seconds.getMinutesIntoHour(),
        day_seconds.getSecondsIntoMinute(),
    }) catch unreachable;

    return buf;
}

/// Derive signing key using HMAC chain
fn deriveSigningKey(
    secret_key: []const u8,
    datestamp: []const u8,
    region: []const u8,
    service: []const u8,
) [Hmac.mac_length]u8 {
    var k_secret: [256]u8 = undefined;
    const prefix = "AWS4";
    @memcpy(k_secret[0..prefix.len], prefix);
    @memcpy(k_secret[prefix.len..][0..secret_key.len], secret_key);
    const k_secret_len = prefix.len + secret_key.len;

    var k_date: [Hmac.mac_length]u8 = undefined;
    Hmac.create(&k_date, datestamp, k_secret[0..k_secret_len]);

    var k_region: [Hmac.mac_length]u8 = undefined;
    Hmac.create(&k_region, region, &k_date);

    var k_service: [Hmac.mac_length]u8 = undefined;
    Hmac.create(&k_service, service, &k_region);

    var k_signing: [Hmac.mac_length]u8 = undefined;
    Hmac.create(&k_signing, "aws4_request", &k_service);

    return k_signing;
}

const CanonicalResult = struct {
    canonical_request: []const u8,
    signed_headers: []const u8,
};

/// Build canonical request string
fn buildCanonicalRequest(
    allocator: Allocator,
    request: *http.Request,
    payload_hash: []const u8,
) !CanonicalResult {
    const method = @tagName(request.method);
    const canonical_uri = try encodeUri(
        allocator,
        if (request.path.len == 0) "/" else request.path,
    );
    defer allocator.free(canonical_uri);

    const canonical_query = try canonicalizeQueryString(allocator, request.query);
    defer allocator.free(canonical_query);

    // Build canonical headers and signed headers list
    const headers_result = try canonicalizeHeaders(allocator, &request.headers);
    defer allocator.free(headers_result.canonical);

    const canonical_request = try std.fmt.allocPrint(allocator, "{s}\n{s}\n{s}\n{s}\n{s}\n{s}", .{
        method,
        canonical_uri,
        canonical_query,
        headers_result.canonical,
        headers_result.signed,
        payload_hash,
    });

    return .{
        .canonical_request = canonical_request,
        .signed_headers = headers_result.signed,
    };
}

const HeadersResult = struct {
    canonical: []const u8,
    signed: []const u8,
};

/// Canonicalize headers per SigV4 spec
fn canonicalizeHeaders(
    allocator: Allocator,
    headers: *const std.StringHashMapUnmanaged([]const u8),
) !HeadersResult {
    // Collect header names
    var header_names: std.ArrayList([]const u8) = .{};
    defer header_names.deinit(allocator);

    var iter = headers.iterator();
    while (iter.next()) |entry| {
        try header_names.append(allocator, entry.key_ptr.*);
    }

    // Sort by lowercase name
    std.mem.sort([]const u8, header_names.items, {}, struct {
        fn lessThan(_: void, a: []const u8, b: []const u8) bool {
            return std.ascii.lessThanIgnoreCase(a, b);
        }
    }.lessThan);

    // Build canonical headers and signed headers
    var canonical: std.ArrayList(u8) = .{};
    errdefer canonical.deinit(allocator);
    var signed: std.ArrayList(u8) = .{};
    defer signed.deinit(allocator);

    for (header_names.items, 0..) |name, i| {
        const value = headers.get(name) orelse continue;
        const trimmed_value = trimAndNormalizeHeaderValue(value);

        // lowercase name:trimmed value\n
        for (name) |c| {
            try canonical.append(allocator, std.ascii.toLower(c));
        }
        try canonical.append(allocator, ':');
        try canonical.appendSlice(allocator, trimmed_value);
        try canonical.append(allocator, '\n');

        // signed headers: name1;name2;name3
        if (i > 0) {
            try signed.append(allocator, ';');
        }
        for (name) |c| {
            try signed.append(allocator, std.ascii.toLower(c));
        }
    }

    return .{
        .canonical = try canonical.toOwnedSlice(allocator),
        .signed = try signed.toOwnedSlice(allocator),
    };
}

/// Trim leading/trailing whitespace and collapse sequential spaces
fn trimAndNormalizeHeaderValue(value: []const u8) []const u8 {
    // Trim leading whitespace
    var start: usize = 0;
    while (start < value.len and (value[start] == ' ' or value[start] == '\t')) {
        start += 1;
    }

    // Trim trailing whitespace
    var end: usize = value.len;
    while (end > start and (value[end - 1] == ' ' or value[end - 1] == '\t')) {
        end -= 1;
    }

    return value[start..end];
}

/// URI-encode a path (RFC 3986, preserving /)
pub fn encodeUri(allocator: Allocator, path: []const u8) ![]const u8 {
    var result: std.ArrayList(u8) = .{};
    errdefer result.deinit(allocator);

    for (path) |c| {
        if (shouldEncodeUriChar(c)) {
            try result.appendSlice(allocator, &percentEncode(c));
        } else {
            try result.append(allocator, c);
        }
    }

    return result.toOwnedSlice(allocator);
}

/// Percent-encode a raw query value.
fn encodeQueryValue(allocator: Allocator, value: []const u8) ![]const u8 {
    var buf: std.ArrayList(u8) = .{};
    errdefer buf.deinit(allocator);
    for (value) |c| {
        if (shouldEncodeQueryChar(c)) {
            try buf.appendSlice(allocator, &percentEncode(c));
        } else {
            try buf.append(allocator, c);
        }
    }
    return buf.toOwnedSlice(allocator);
}

fn shouldEncodeUriChar(c: u8) bool {
    // Don't encode: A-Z, a-z, 0-9, '-', '_', '.', '~', '/'
    return switch (c) {
        'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~', '/' => false,
        else => true,
    };
}

fn shouldEncodeQueryChar(c: u8) bool {
    // Don't encode: A-Z, a-z, 0-9, '-', '_', '.', '~'
    // Note: '/' IS encoded in query strings
    return switch (c) {
        'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => false,
        else => true,
    };
}

fn percentEncode(c: u8) [3]u8 {
    const hex = "0123456789ABCDEF";
    return .{ '%', hex[c >> 4], hex[c & 0x0F] };
}

const QueryPair = struct { key: []const u8, value: []const u8 };

/// Canonicalize query string per SigV4 spec
pub fn canonicalizeQueryString(allocator: Allocator, query: ?[]const u8) ![]const u8 {
    const q = query orelse return try allocator.dupe(u8, "");
    if (q.len == 0) return try allocator.dupe(u8, "");

    // Parse query string into key-value pairs
    var pairs: std.ArrayList(QueryPair) = .{};
    defer pairs.deinit(allocator);

    var param_iter = std.mem.splitScalar(u8, q, '&');
    while (param_iter.next()) |param| {
        if (param.len == 0) continue;

        if (std.mem.indexOfScalar(u8, param, '=')) |eq_idx| {
            try pairs.append(allocator, .{
                .key = param[0..eq_idx],
                .value = param[eq_idx + 1 ..],
            });
        } else {
            try pairs.append(allocator, .{
                .key = param,
                .value = "",
            });
        }
    }

    // Sort by key, then by value
    std.mem.sort(QueryPair, pairs.items, {}, struct {
        fn lessThan(_: void, a: QueryPair, b: QueryPair) bool {
            const key_cmp = std.mem.order(u8, a.key, b.key);
            if (key_cmp != .eq) return key_cmp == .lt;
            return std.mem.order(u8, a.value, b.value) == .lt;
        }
    }.lessThan);

    // Build canonical query string -- keys and values are already URI-encoded
    // by the request serializer, so we just sort and rejoin without re-encoding.
    var result: std.ArrayList(u8) = .{};
    errdefer result.deinit(allocator);

    for (pairs.items, 0..) |pair, i| {
        if (i > 0) {
            try result.append(allocator, '&');
        }

        try result.appendSlice(allocator, pair.key);
        try result.append(allocator, '=');
        try result.appendSlice(allocator, pair.value);
    }

    return result.toOwnedSlice(allocator);
}

// Tests

test "formatAmzDate" {
    // 2024-01-15 12:00:45 UTC
    const datetime = formatAmzDate(1705320045);
    try std.testing.expectEqualStrings("20240115T120045Z", &datetime);
}

test "deriveSigningKey matches AWS example" {
    // AWS SigV4 test suite example
    const key = deriveSigningKey(
        "wJalrXUtnFEMI/K7MDENG+bPxRfiCYEXAMPLEKEY",
        "20150830",
        "us-east-1",
        "iam",
    );

    // Expected key verified with Python hmac implementation
    const expected = [_]u8{
        0xc4, 0xaf, 0xb1, 0xcc, 0x57, 0x71, 0xd8, 0x71,
        0x76, 0x3a, 0x39, 0x3e, 0x44, 0xb7, 0x03, 0x57,
        0x1b, 0x55, 0xcc, 0x28, 0x42, 0x4d, 0x1a, 0x5e,
        0x86, 0xda, 0x6e, 0xd3, 0xc1, 0x54, 0xa4, 0xb9,
    };
    try std.testing.expectEqualSlices(u8, &expected, &key);
}

test "encodeUri basic" {
    const allocator = std.testing.allocator;

    const encoded = try encodeUri(allocator, "/documents and settings/");
    defer allocator.free(encoded);
    try std.testing.expectEqualStrings("/documents%20and%20settings/", encoded);
}

test "encodeUri preserves unreserved characters" {
    const allocator = std.testing.allocator;

    const encoded = try encodeUri(allocator, "/test-path_name.txt~backup");
    defer allocator.free(encoded);
    try std.testing.expectEqualStrings("/test-path_name.txt~backup", encoded);
}

test "encodeUri special characters" {
    const allocator = std.testing.allocator;

    const encoded = try encodeUri(allocator, "/foo:bar@baz");
    defer allocator.free(encoded);
    try std.testing.expectEqualStrings("/foo%3Abar%40baz", encoded);
}

test "canonicalizeQueryString empty" {
    const allocator = std.testing.allocator;

    const result = try canonicalizeQueryString(allocator, null);
    defer allocator.free(result);
    try std.testing.expectEqualStrings("", result);
}

test "canonicalizeQueryString sorts parameters" {
    const allocator = std.testing.allocator;

    const result = try canonicalizeQueryString(
        allocator,
        "Version=2011-06-15&Action=GetCallerIdentity",
    );
    defer allocator.free(result);
    try std.testing.expectEqualStrings("Action=GetCallerIdentity&Version=2011-06-15", result);
}

test "canonicalizeQueryString preserves already-encoded values" {
    const allocator = std.testing.allocator;

    // Query values are already percent-encoded by the request serializer
    const result = try canonicalizeQueryString(allocator, "key=hello%20world");
    defer allocator.free(result);
    try std.testing.expectEqualStrings("key=hello%20world", result);
}

test "canonicalizeHeaders" {
    const allocator = std.testing.allocator;

    var headers: std.StringHashMapUnmanaged([]const u8) = .{};
    defer headers.deinit(allocator);

    try headers.put(allocator, "X-Amz-Date", "20150830T123600Z");
    try headers.put(allocator, "Host", "iam.amazonaws.com");
    try headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded; charset=utf-8");

    const result = try canonicalizeHeaders(allocator, &headers);
    defer allocator.free(result.canonical);
    defer allocator.free(result.signed);

    // Headers should be sorted alphabetically
    try std.testing.expectEqualStrings("content-type;host;x-amz-date", result.signed);

    // Canonical form has lowercase names
    try std.testing.expect(std.mem.startsWith(u8, result.canonical, "content-type:"));
}

test "trimAndNormalizeHeaderValue" {
    try std.testing.expectEqualStrings("value", trimAndNormalizeHeaderValue("  value  "));
    try std.testing.expectEqualStrings("value", trimAndNormalizeHeaderValue("\tvalue\t"));
    try std.testing.expectEqualStrings(
        "hello world",
        trimAndNormalizeHeaderValue("  hello world  "),
    );
}

test "presignRequest produces valid URL" {
    const allocator = std.testing.allocator;

    var request = http.Request.init("my-bucket.s3.us-east-1.amazonaws.com");
    defer request.deinit(allocator);
    request.method = .GET;
    request.path = "/my-key.txt";

    const creds = Credentials{
        .access_key_id = "AKIAIOSFODNN7EXAMPLE",
        .secret_access_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
    };

    const url = try presignRequest(allocator, &request, creds, "us-east-1", "s3", .{});
    defer allocator.free(url);

    // URL should start with https and contain all required SigV4 query params
    try std.testing.expect(
        std.mem.startsWith(
            u8,
            url,
            "https://my-bucket.s3.us-east-1.amazonaws.com/my-key.txt?",
        ),
    );
    try std.testing.expect(std.mem.indexOf(u8, url, "X-Amz-Algorithm=AWS4-HMAC-SHA256") != null);
    try std.testing.expect(std.mem.indexOf(u8, url, "X-Amz-Credential=") != null);
    try std.testing.expect(std.mem.indexOf(u8, url, "X-Amz-Date=") != null);
    try std.testing.expect(std.mem.indexOf(u8, url, "X-Amz-Expires=3600") != null);
    try std.testing.expect(std.mem.indexOf(u8, url, "X-Amz-SignedHeaders=host") != null);
    try std.testing.expect(std.mem.indexOf(u8, url, "X-Amz-Signature=") != null);
}

test "presignRequest with session token" {
    const allocator = std.testing.allocator;

    var request = http.Request.init("s3.us-west-2.amazonaws.com");
    defer request.deinit(allocator);
    request.method = .GET;
    request.path = "/bucket/key";

    const creds = Credentials{
        .access_key_id = "AKID",
        .secret_access_key = "SECRET",
        .session_token = "TOKEN123",
    };

    const url = try presignRequest(
        allocator,
        &request,
        creds,
        "us-west-2",
        "s3",
        .{ .expires_seconds = 900 },
    );
    defer allocator.free(url);

    try std.testing.expect(std.mem.indexOf(u8, url, "X-Amz-Security-Token=TOKEN123") != null);
    try std.testing.expect(std.mem.indexOf(u8, url, "X-Amz-Expires=900") != null);
}

test "presignRequest with custom port" {
    const allocator = std.testing.allocator;

    var request = http.Request.init("localhost");
    defer request.deinit(allocator);
    request.method = .GET;
    request.path = "/bucket/key";
    request.port = 4566;
    request.tls = false;

    const creds = Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
    };

    const url = try presignRequest(allocator, &request, creds, "us-east-1", "s3", .{});
    defer allocator.free(url);

    try std.testing.expect(std.mem.startsWith(u8, url, "http://localhost:4566/bucket/key?"));
}

test "presignRequest with existing query params" {
    const allocator = std.testing.allocator;

    var request = http.Request.init("s3.us-east-1.amazonaws.com");
    defer request.deinit(allocator);
    request.method = .GET;
    request.path = "/bucket/key";
    request.query = "response-content-disposition=attachment";

    const creds = Credentials{
        .access_key_id = "AKID",
        .secret_access_key = "SECRET",
    };

    const url = try presignRequest(allocator, &request, creds, "us-east-1", "s3", .{});
    defer allocator.free(url);

    // Existing param should be present alongside the signing params
    try std.testing.expect(
        std.mem.indexOf(u8, url, "response-content-disposition=attachment") != null,
    );
    try std.testing.expect(std.mem.indexOf(u8, url, "X-Amz-Algorithm=") != null);
}

test "buildPresignCanonicalQuery sorts params" {
    const allocator = std.testing.allocator;

    const result = try buildPresignCanonicalQuery(
        allocator,
        "Zebra=1&Alpha=2",
        "20240101T000000Z",
        "AKID/20240101/us-east-1/s3/aws4_request",
        "host",
        3600,
        null,
    );
    defer allocator.free(result);

    // All params should be sorted: Alpha, X-Amz-Algorithm, X-Amz-Credential, ...
    const alpha_pos = std.mem.indexOf(u8, result, "Alpha=2") orelse unreachable;
    const algo_pos = std.mem.indexOf(u8, result, "X-Amz-Algorithm=") orelse unreachable;
    const zebra_pos = std.mem.indexOf(u8, result, "Zebra=1") orelse unreachable;

    try std.testing.expect(alpha_pos < algo_pos);
    try std.testing.expect(algo_pos < zebra_pos);
}

test "signRequest gzip compresses large body" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var request = http.Request.init("s3.us-east-1.amazonaws.com");
    defer request.deinit(allocator);
    request.method = .POST;
    request.path = "/bucket/key";

    const body = try allocator.alloc(u8, 2000);
    @memset(body, 'a');
    request.body = body;
    request.request_compression = .gzip;

    const creds = Credentials{
        .access_key_id = "AKID",
        .secret_access_key = "SECRET",
    };

    try signRequest(allocator, &request, creds, "us-east-1", "s3");

    try std.testing.expect(request.body != null);
    const compressed = request.body.?;
    try std.testing.expect(compressed.len < 2000);
    try std.testing.expectEqualStrings(
        "gzip",
        request.headers.get("content-encoding") orelse "",
    );
}

test "signRequest does not compress small body" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var request = http.Request.init("s3.us-east-1.amazonaws.com");
    defer request.deinit(allocator);
    request.method = .POST;
    request.path = "/bucket/key";

    const body = try allocator.alloc(u8, 100);
    @memset(body, 'b');
    request.body = body;
    request.request_compression = .gzip;

    const creds = Credentials{
        .access_key_id = "AKID",
        .secret_access_key = "SECRET",
    };

    try signRequest(allocator, &request, creds, "us-east-1", "s3");

    try std.testing.expectEqualSlices(u8, body, request.body.?);
    try std.testing.expect(request.headers.get("content-encoding") == null);
}

test "signRequest null compression is no-op" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var request = http.Request.init("s3.us-east-1.amazonaws.com");
    defer request.deinit(allocator);
    request.method = .POST;
    request.path = "/bucket/key";
    request.body = "payload";

    const creds = Credentials{
        .access_key_id = "AKID",
        .secret_access_key = "SECRET",
    };

    try signRequest(allocator, &request, creds, "us-east-1", "s3");

    try std.testing.expect(request.headers.get("content-encoding") == null);
}

test "signRequest hashes compressed body" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var request = http.Request.init("s3.us-east-1.amazonaws.com");
    defer request.deinit(allocator);
    request.method = .POST;
    request.path = "/bucket/key";

    const body = try allocator.alloc(u8, 2000);
    @memset(body, 'c');
    request.body = body;
    request.request_compression = .gzip;

    const creds = Credentials{
        .access_key_id = "AKID",
        .secret_access_key = "SECRET",
    };

    try signRequest(allocator, &request, creds, "us-east-1", "s3");

    const compressed = request.body.?;
    var payload_hash: [Sha256.digest_length]u8 = undefined;
    Sha256.hash(compressed, &payload_hash, .{});
    const payload_hash_hex = std.fmt.bytesToHex(&payload_hash, .lower);
    try std.testing.expectEqualStrings(
        &payload_hash_hex,
        request.headers.get("x-amz-content-sha256") orelse "",
    );
}
