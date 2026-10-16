//! Credentials from cached AWS CLI login sessions.

const std = @import("std");
const Allocator = std.mem.Allocator;
const Credentials = @import("credentials.zig").Credentials;
const date = @import("date.zig");
const http = @import("http.zig");
const signing = @import("signing.zig");
const endpoint = @import("endpoint.zig");
const url = @import("url.zig");
const Ecdsa = std.crypto.sign.ecdsa.EcdsaP256Sha256;

pub const Error = error{
    OutOfMemory,
    LoginCacheNotFound,
    LoginCacheReadFailed,
    LoginCacheInvalid,
    LoginSessionExpired,
    LoginAccessDenied,
    LoginRefreshFailed,
    LoginCacheWriteFailed,
};

pub const LoginProvider = struct {
    io: std.Io,
    env_map: *const std.process.Environ.Map,
    login_session: []const u8,
    region: []const u8,
    endpoint_url: ?[]const u8 = null,

    /// Returns owned credentials. The caller frees the three credential strings.
    pub fn getCredentials(self: *LoginProvider, allocator: Allocator) Error!Credentials {
        var arena = std.heap.ArenaAllocator.init(allocator);
        defer arena.deinit();
        const scratch = arena.allocator();
        const path = try self.cachePath(scratch);
        const content = std.Io.Dir.cwd().readFileAlloc(
            self.io,
            path,
            scratch,
            .limited(1024 * 1024),
        ) catch |err| return switch (err) {
            error.OutOfMemory => error.OutOfMemory,
            error.FileNotFound => error.LoginCacheNotFound,
            else => error.LoginCacheReadFailed,
        };
        var token = std.json.parseFromSliceLeaky(std.json.Value, scratch, content, .{
            .allocate = .alloc_always,
        }) catch |err| return switch (err) {
            error.OutOfMemory => error.OutOfMemory,
            else => error.LoginCacheInvalid,
        };
        _ = try stringField(token, "clientId");
        _ = try stringField(token, "refreshToken");
        _ = try stringField(token, "dpopKey");
        const access_token = try objectField(token, "accessToken");
        _ = try stringField(access_token, "accountId");
        _ = try stringField(access_token, "accessKeyId");
        _ = try stringField(access_token, "secretAccessKey");
        _ = try stringField(access_token, "sessionToken");
        const expiration = date.parseIso8601(try stringField(access_token, "expiresAt")) catch
            return error.LoginCacheInvalid;
        const now = std.Io.Clock.real.now(self.io).toSeconds();
        if (expiration <= now + @import("credentials.zig").default_expiry_buffer) {
            try self.refresh(scratch, &token, now);
            const encoded = try std.json.Stringify.valueAlloc(scratch, token, .{});
            self.saveCache(path, encoded) catch return error.LoginCacheWriteFailed;
        }

        const current = try objectField(token, "accessToken");
        const access_key = try allocator.dupe(u8, try stringField(current, "accessKeyId"));
        errdefer allocator.free(access_key);
        const secret = try allocator.dupe(u8, try stringField(current, "secretAccessKey"));
        errdefer allocator.free(secret);
        const session_token = try allocator.dupe(u8, try stringField(current, "sessionToken"));
        errdefer allocator.free(session_token);
        return .{
            .access_key_id = access_key,
            .secret_access_key = secret,
            .session_token = session_token,
            .expiration = date.parseIso8601(try stringField(current, "expiresAt")) catch
                return error.LoginCacheInvalid,
        };
    }

    fn cachePath(self: *const LoginProvider, allocator: Allocator) Error![]const u8 {
        const session = std.mem.trim(u8, self.login_session, " \t\r\n");
        if (session.len == 0) return error.LoginCacheInvalid;
        var hash: [32]u8 = undefined;
        std.crypto.hash.sha2.Sha256.hash(session, &hash, .{});
        const filename = std.fmt.bytesToHex(hash, .lower) ++ ".json";
        if (self.env_map.get("AWS_LOGIN_CACHE_DIRECTORY")) |directory| {
            if (directory.len > 0) {
                return std.Io.Dir.path.join(allocator, &.{ directory, filename });
            }
        }
        const home = self.env_map.get("HOME") orelse self.env_map.get("USERPROFILE") orelse
            return error.LoginCacheNotFound;
        return std.Io.Dir.path.join(allocator, &.{ home, ".aws", "login", "cache", filename });
    }

    fn refresh(
        self: *LoginProvider,
        allocator: Allocator,
        token: *std.json.Value,
        now: i64,
    ) Error!void {
        const base = self.endpoint_url orelse self.env_map.get("AWS_ENDPOINT_URL_SIGNIN") orelse
            try loginEndpoint(allocator, self.region);
        const token_url = try std.fmt.allocPrint(allocator, "{s}/v1/token", .{
            std.mem.trimEnd(u8, base, "/"),
        });
        const ep = url.parseEndpoint(base) catch return error.LoginRefreshFailed;
        const proof = try createProof(
            allocator,
            self.io,
            try stringField(token.*, "dpopKey"),
            token_url,
        );
        const body = try std.json.Stringify.valueAlloc(allocator, .{
            .clientId = try stringField(token.*, "clientId"),
            .grantType = "refresh_token",
            .refreshToken = try stringField(token.*, "refreshToken"),
        }, .{});
        var request = http.Request.init(ep.host);
        request.method = .POST;
        request.port = ep.port;
        request.tls = ep.tls;
        request.path = "/v1/token";
        request.body = body;
        try request.headers.put(allocator, "Content-Type", "application/json");
        try request.headers.put(allocator, "DPoP", proof);

        // A DPoP proof must be unique for each request, including retries.
        var response = http.sendRequestWithOptions(
            allocator,
            self.io,
            self.env_map,
            &request,
            .{ .max_attempts = 1, .keep_alive = false },
        ) catch |err| return switch (err) {
            error.OutOfMemory => error.OutOfMemory,
            else => error.LoginRefreshFailed,
        };
        defer response.deinit();
        const result = std.json.parseFromSliceLeaky(std.json.Value, allocator, response.body, .{
            .allocate = .alloc_always,
        }) catch |err| return switch (err) {
            error.OutOfMemory => error.OutOfMemory,
            else => error.LoginRefreshFailed,
        };
        if (!response.isSuccess()) {
            const code = stringField(result, "error") catch "";
            if (std.mem.eql(u8, code, "TOKEN_EXPIRED") or
                std.mem.eql(u8, code, "USER_CREDENTIALS_CHANGED")) return error.LoginSessionExpired;
            if (std.mem.eql(u8, code, "INSUFFICIENT_PERMISSIONS")) return error.LoginAccessDenied;
            return error.LoginRefreshFailed;
        }
        updateToken(allocator, token, result, now) catch |err| return switch (err) {
            error.OutOfMemory => error.OutOfMemory,
            else => error.LoginRefreshFailed,
        };
    }

    fn updateToken(
        allocator: Allocator,
        token: *std.json.Value,
        result: std.json.Value,
        now: i64,
    ) Error!void {
        const access = try objectField(result, "accessToken");
        const expires_in = try field(result, "expiresIn");
        if (expires_in != .integer or expires_in.integer <= 0 or
            expires_in.integer > 86400) return error.LoginRefreshFailed;
        const amz_date = signing.formatAmzDate(now + expires_in.integer);
        const expires_at = try std.fmt.allocPrint(allocator, "{s}-{s}-{s}T{s}:{s}:{s}Z", .{
            amz_date[0..4],  amz_date[4..6],   amz_date[6..8],
            amz_date[9..11], amz_date[11..13], amz_date[13..15],
        });
        var current = try objectField(token.*, "accessToken");
        for ([_][]const u8{ "accessKeyId", "secretAccessKey", "sessionToken" }) |name| {
            try current.object.put(allocator, name, .{ .string = try stringField(access, name) });
        }
        try current.object.put(allocator, "expiresAt", .{ .string = expires_at });
        try token.object.put(allocator, "accessToken", current);
        try token.object.put(allocator, "refreshToken", .{
            .string = try stringField(result, "refreshToken"),
        });
    }

    fn saveCache(self: *LoginProvider, path: []const u8, content: []const u8) !void {
        var file = try std.Io.Dir.cwd().createFileAtomic(self.io, path, .{
            .replace = true,
            .permissions = if (@import("builtin").os.tag == .windows)
                .default_file
            else
                .fromMode(0o600),
        });
        defer file.deinit(self.io);
        try file.file.writeStreamingAll(self.io, content);
        try file.file.sync(self.io);
        try file.replace(self.io);
    }
};

pub fn credentialError(err: anyerror) ?Error {
    return switch (err) {
        error.OutOfMemory,
        error.LoginCacheNotFound,
        error.LoginCacheReadFailed,
        error.LoginCacheInvalid,
        error.LoginSessionExpired,
        error.LoginAccessDenied,
        error.LoginRefreshFailed,
        error.LoginCacheWriteFailed,
        => @errorCast(err),
        else => null,
    };
}

fn field(value: std.json.Value, name: []const u8) Error!std.json.Value {
    if (value != .object) return error.LoginCacheInvalid;
    return value.object.get(name) orelse error.LoginCacheInvalid;
}

fn objectField(value: std.json.Value, name: []const u8) Error!std.json.Value {
    const result = try field(value, name);
    if (result != .object) return error.LoginCacheInvalid;
    return result;
}

fn stringField(value: std.json.Value, name: []const u8) Error![]const u8 {
    const result = try field(value, name);
    if (result != .string or result.string.len == 0) return error.LoginCacheInvalid;
    return result.string;
}

fn loginEndpoint(allocator: Allocator, region: []const u8) Error![]const u8 {
    const partition = endpoint.partitionForRegion(region);
    const suffixes = std.StaticStringMap([]const u8).initComptime(.{
        .{ "aws", "aws.amazon.com" },
        .{ "aws-cn", "amazonaws.cn" },
        .{ "aws-us-gov", "amazonaws-us-gov.com" },
        .{ "aws-iso", "c2shome.ic.gov" },
        .{ "aws-iso-b", "sc2shome.sgov.gov" },
        .{ "aws-iso-e", "csphome.adc-e.uk" },
        .{ "aws-iso-f", "csphome.hci.ic.gov" },
        .{ "aws-eusc", "amazonaws-eusc.eu" },
    });
    const suffix = suffixes.get(partition.name) orelse return error.LoginRefreshFailed;
    return std.fmt.allocPrint(allocator, "https://{s}.signin.{s}", .{ region, suffix });
}

fn createProof(
    allocator: Allocator,
    io: std.Io,
    pem: []const u8,
    token_url: []const u8,
) Error![]const u8 {
    const key_pair = try parseKey(allocator, pem);
    const public = key_pair.public_key.toUncompressedSec1();
    const header = try std.json.Stringify.valueAlloc(allocator, .{
        .typ = "dpop+jwt",
        .alg = "ES256",
        .jwk = .{
            .kty = "EC",
            .crv = "P-256",
            .x = try encodeBase64(allocator, public[1..33]),
            .y = try encodeBase64(allocator, public[33..65]),
        },
    }, .{});
    var nonce: [16]u8 = undefined;
    io.random(&nonce);
    const payload = try std.json.Stringify.valueAlloc(allocator, .{
        .jti = &std.fmt.bytesToHex(nonce, .lower),
        .htm = "POST",
        .htu = token_url,
        .iat = std.Io.Clock.real.now(io).toSeconds(),
    }, .{});
    const message = try std.fmt.allocPrint(allocator, "{s}.{s}", .{
        try encodeBase64(allocator, header),
        try encodeBase64(allocator, payload),
    });
    var noise: [Ecdsa.noise_length]u8 = undefined;
    io.random(&noise);
    const signature = key_pair.sign(message, noise) catch return error.LoginCacheInvalid;
    return std.fmt.allocPrint(allocator, "{s}.{s}", .{
        message,
        try encodeBase64(allocator, &signature.toBytes()),
    });
}

fn encodeBase64(allocator: Allocator, bytes: []const u8) Allocator.Error![]const u8 {
    const encoder = std.base64.url_safe_no_pad.Encoder;
    const buffer = try allocator.alloc(u8, encoder.calcSize(bytes.len));
    return encoder.encode(buffer, bytes);
}

fn parseKey(allocator: Allocator, pem: []const u8) Error!Ecdsa.KeyPair {
    const begin = "-----BEGIN EC PRIVATE KEY-----";
    const end = "-----END EC PRIVATE KEY-----";
    const trimmed = std.mem.trim(u8, pem, " \t\r\n");
    if (trimmed.len < begin.len + end.len or
        !std.mem.startsWith(u8, trimmed, begin) or !std.mem.endsWith(u8, trimmed, end))
        return error.LoginCacheInvalid;
    const decoder = std.base64.standard.decoderWithIgnore(" \t\r\n");
    const encoded = trimmed[begin.len .. trimmed.len - end.len];
    const buffer = try allocator.alloc(u8, decoder.calcSizeUpperBound(encoded.len));
    const length = decoder.decode(buffer, encoded) catch return error.LoginCacheInvalid;
    var der: []const u8 = buffer[0..length];
    var sequence = try takeDer(&der, 0x30);
    if (der.len != 0 or !std.mem.eql(u8, try takeDer(&sequence, 0x02), &.{1}))
        return error.LoginCacheInvalid;
    const secret = try takeDer(&sequence, 0x04);
    if (secret.len != 32) return error.LoginCacheInvalid;
    const curve = try takeDer(&sequence, 0xa0);
    const p256_oid = [_]u8{ 0x06, 0x08, 0x2a, 0x86, 0x48, 0xce, 0x3d, 0x03, 0x01, 0x07 };
    if (!std.mem.eql(u8, curve, &p256_oid)) return error.LoginCacheInvalid;
    if (sequence.len > 0) _ = try takeDer(&sequence, 0xa1);
    if (sequence.len != 0) return error.LoginCacheInvalid;
    const key = Ecdsa.SecretKey.fromBytes(secret[0..32].*) catch return error.LoginCacheInvalid;
    return Ecdsa.KeyPair.fromSecretKey(key) catch error.LoginCacheInvalid;
}

fn takeDer(bytes: *[]const u8, tag: u8) Error![]const u8 {
    if (bytes.len < 2 or bytes.*[0] != tag) return error.LoginCacheInvalid;
    const size_byte = bytes.*[1];
    bytes.* = bytes.*[2..];
    var length: usize = size_byte;
    if (size_byte & 0x80 != 0) {
        const size_length = size_byte & 0x7f;
        if (size_length == 0 or size_length > 2 or size_length > bytes.len)
            return error.LoginCacheInvalid;
        length = 0;
        for (bytes.*[0..size_length]) |byte| length = (length << 8) | byte;
        bytes.* = bytes.*[size_length..];
    }
    if (length > bytes.len) return error.LoginCacheInvalid;
    const value = bytes.*[0..length];
    bytes.* = bytes.*[length..];
    return value;
}

test "login provider reads cached credentials" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    const session = "arn:aws:iam::111111111111:user/test";
    var hash: [32]u8 = undefined;
    std.crypto.hash.sha2.Sha256.hash(session, &hash, .{});
    const filename = std.fmt.bytesToHex(hash, .lower) ++ ".json";
    try tmp.dir.writeFile(std.testing.io, .{
        .sub_path = filename,
        .data = test_cache,
    });
    var env_map: std.process.Environ.Map = .init(allocator);
    defer env_map.deinit();
    var path_buf: [std.fs.max_path_bytes]u8 = undefined;
    try env_map.put("AWS_LOGIN_CACHE_DIRECTORY", try std.fmt.bufPrint(
        &path_buf,
        ".zig-cache/tmp/{s}",
        .{tmp.sub_path},
    ));
    var provider = LoginProvider{
        .io = std.testing.io,
        .env_map = &env_map,
        .login_session = session,
        .region = "us-west-2",
    };
    const creds = try provider.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        allocator.free(creds.session_token.?);
    }
    try std.testing.expectEqualStrings("LOGIN", creds.access_key_id);
    try std.testing.expectEqualStrings("login-secret", creds.secret_access_key);
    try std.testing.expectEqualStrings("login-token", creds.session_token.?);
    try std.testing.expectEqual(@as(i64, 4070908800), creds.expiration.?);
}

test "login cache path uses home and a trimmed SHA256 session name" {
    const allocator = std.testing.allocator;
    var env_map: std.process.Environ.Map = .init(allocator);
    defer env_map.deinit();
    try env_map.put("HOME", "/test-home");
    var provider = LoginProvider{
        .io = std.testing.io,
        .env_map = &env_map,
        .login_session = " test-session \n",
        .region = "us-west-2",
    };
    const path = try provider.cachePath(allocator);
    defer allocator.free(path);
    const expected = try std.Io.Dir.path.join(allocator, &.{
        "/test-home",
        ".aws",
        "login",
        "cache",
        "4943e43bc034c8bf90e1c2895796b954d3c34dc90afe838448dee6678fa765f8.json",
    });
    defer allocator.free(expected);
    try std.testing.expectEqualStrings(expected, path);
}

test "login provider reports missing and invalid caches" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    var env_map: std.process.Environ.Map = .init(allocator);
    defer env_map.deinit();
    var path_buf: [std.fs.max_path_bytes]u8 = undefined;
    try env_map.put("AWS_LOGIN_CACHE_DIRECTORY", try std.fmt.bufPrint(
        &path_buf,
        ".zig-cache/tmp/{s}",
        .{tmp.sub_path},
    ));
    var provider = LoginProvider{
        .io = std.testing.io,
        .env_map = &env_map,
        .login_session = "test-session",
        .region = "us-west-2",
    };
    try std.testing.expectError(error.LoginCacheNotFound, provider.getCredentials(allocator));
    const path = try provider.cachePath(allocator);
    defer allocator.free(path);
    for ([_][]const u8{
        "not json", "null", "[]", "{}", "{\"accessToken\":{}}",
    }) |content| {
        try std.Io.Dir.cwd().writeFile(std.testing.io, .{ .sub_path = path, .data = content });
        try std.testing.expectError(error.LoginCacheInvalid, provider.getCredentials(allocator));
    }
}

test "login refresh creates a signed DPoP proof and saves rotated credentials" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const scratch = arena.allocator();
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    var env_map: std.process.Environ.Map = .init(allocator);
    defer env_map.deinit();
    var path_buf: [std.fs.max_path_bytes]u8 = undefined;
    try env_map.put("AWS_LOGIN_CACHE_DIRECTORY", try std.fmt.bufPrint(
        &path_buf,
        ".zig-cache/tmp/{s}",
        .{tmp.sub_path},
    ));
    var server = try LoginTestServer.init();
    defer server.server.deinit(std.testing.io);
    var group: std.Io.Group = .init;
    defer group.cancel(std.testing.io);
    try group.concurrent(std.testing.io, LoginTestServer.run, .{&server});
    const base = try std.fmt.allocPrint(scratch, "http://127.0.0.1:{d}", .{
        server.server.socket.address.getPort(),
    });
    var provider = LoginProvider{
        .io = std.testing.io,
        .env_map = &env_map,
        .login_session = "test-session",
        .region = "us-west-2",
        .endpoint_url = base,
    };
    const path = try provider.cachePath(scratch);
    var token = try std.json.parseFromSliceLeaky(std.json.Value, scratch, test_cache, .{});
    try token.object.put(scratch, "dpopKey", .{ .string = test_pem });
    var access_token = try objectField(token, "accessToken");
    try access_token.object.put(scratch, "expiresAt", .{ .string = "2000-01-01T00:00:00Z" });
    try token.object.put(scratch, "accessToken", access_token);
    const expired_cache = try std.json.Stringify.valueAlloc(scratch, token, .{});
    try std.Io.Dir.cwd().writeFile(std.testing.io, .{ .sub_path = path, .data = expired_cache });

    const before = std.Io.Clock.real.now(std.testing.io).toSeconds();
    const creds = try provider.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        allocator.free(creds.session_token.?);
    }
    try std.testing.expectEqualStrings("REFRESHED", creds.access_key_id);
    try std.testing.expectEqualStrings("refreshed-secret", creds.secret_access_key);
    try std.testing.expectEqualStrings("refreshed-token", creds.session_token.?);
    const after = std.Io.Clock.real.now(std.testing.io).toSeconds();
    try std.testing.expect(creds.expiration.? >= before + 900);
    try std.testing.expect(creds.expiration.? <= after + 900);
    try group.await(std.testing.io);

    const request = server.request[0..server.request_len];
    try std.testing.expect(std.mem.startsWith(u8, request, "POST /v1/token HTTP/1.1\r\n"));
    const body_start = (std.mem.find(u8, request, "\r\n\r\n") orelse
        return error.TestUnexpectedResult) + 4;
    const body = try std.json.parseFromSliceLeaky(
        std.json.Value,
        scratch,
        request[body_start..],
        .{},
    );
    try std.testing.expectEqualStrings("refresh_token", try stringField(body, "grantType"));
    try std.testing.expectEqualStrings("test-client", try stringField(body, "clientId"));
    try std.testing.expectEqualStrings("test-refresh-token", try stringField(body, "refreshToken"));
    const proof_start = (std.mem.find(u8, request, "DPoP: ") orelse
        return error.TestUnexpectedResult) + "DPoP: ".len;
    const proof_end = std.mem.findScalarPos(u8, request, proof_start, '\r') orelse
        return error.TestUnexpectedResult;
    try verifyTestProof(scratch, request[proof_start..proof_end], base);
    try std.testing.expect(std.mem.find(u8, request[0..body_start], "Authorization:") == null);

    const saved = try std.Io.Dir.cwd().readFileAlloc(std.testing.io, path, scratch, .unlimited);
    const saved_token = try std.json.parseFromSliceLeaky(std.json.Value, scratch, saved, .{});
    try std.testing.expectEqualStrings(
        "rotated-refresh-token",
        try stringField(saved_token, "refreshToken"),
    );
    try std.testing.expectEqualStrings(
        "test-identity",
        try stringField(saved_token, "identityToken"),
    );
    try std.testing.expectEqualStrings(test_pem, try stringField(saved_token, "dpopKey"));
    if (@import("builtin").os.tag != .windows) {
        const cache_file = try std.Io.Dir.cwd().openFile(std.testing.io, path, .{});
        defer cache_file.close(std.testing.io);
        try std.testing.expectEqual(
            @as(std.posix.mode_t, 0o600),
            (try cache_file.stat(std.testing.io)).permissions.toMode() & 0o777,
        );
    }
    const reread = try provider.getCredentials(allocator);
    defer {
        allocator.free(reread.access_key_id);
        allocator.free(reread.secret_access_key);
        allocator.free(reread.session_token.?);
    }
    try std.testing.expectEqualStrings("REFRESHED", reread.access_key_id);
    try std.testing.expectEqual(creds.expiration, reread.expiration);
}

test "login refresh preserves the cache when authentication fails" {
    const allocator = std.testing.allocator;
    const cases = [_]struct { status: u16, body: []const u8, expected: Error }{
        .{
            .status = 403,
            .body = "{\"error\":\"TOKEN_EXPIRED\"}",
            .expected = error.LoginSessionExpired,
        },
        .{
            .status = 403,
            .body = "{\"error\":\"INSUFFICIENT_PERMISSIONS\"}",
            .expected = error.LoginAccessDenied,
        },
        .{
            .status = 200,
            .body = "{\"accessToken\":{}}",
            .expected = error.LoginRefreshFailed,
        },
    };
    for (cases) |case| {
        var arena = std.heap.ArenaAllocator.init(allocator);
        defer arena.deinit();
        const scratch = arena.allocator();
        var env_map: std.process.Environ.Map = .init(allocator);
        defer env_map.deinit();
        var tmp = std.testing.tmpDir(.{});
        defer tmp.cleanup();
        const base_path = try std.fmt.allocPrint(scratch, ".zig-cache/tmp/{s}", .{tmp.sub_path});
        try env_map.put("AWS_LOGIN_CACHE_DIRECTORY", base_path);
        var server = try LoginTestServer.init();
        server.status = case.status;
        server.body = case.body;
        defer server.server.deinit(std.testing.io);
        var group: std.Io.Group = .init;
        defer group.cancel(std.testing.io);
        try group.concurrent(std.testing.io, LoginTestServer.run, .{&server});
        var provider = LoginProvider{
            .io = std.testing.io,
            .env_map = &env_map,
            .login_session = "test-session",
            .region = "us-west-2",
            .endpoint_url = try std.fmt.allocPrint(scratch, "http://127.0.0.1:{d}", .{
                server.server.socket.address.getPort(),
            }),
        };
        var token = try std.json.parseFromSliceLeaky(std.json.Value, scratch, test_cache, .{});
        try token.object.put(scratch, "dpopKey", .{ .string = test_pem });
        var access_token = try objectField(token, "accessToken");
        try access_token.object.put(scratch, "expiresAt", .{ .string = "2000-01-01T00:00:00Z" });
        try token.object.put(scratch, "accessToken", access_token);
        const original = try std.json.Stringify.valueAlloc(scratch, token, .{});
        const path = try provider.cachePath(scratch);
        try std.Io.Dir.cwd().writeFile(std.testing.io, .{ .sub_path = path, .data = original });
        try std.testing.expectError(case.expected, provider.getCredentials(allocator));
        try group.await(std.testing.io);
        const saved = try std.Io.Dir.cwd().readFileAlloc(std.testing.io, path, scratch, .unlimited);
        try std.testing.expectEqualStrings(original, saved);
    }
}

test "login rejects invalid EC key encodings" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    for ([_][]const u8{
        "",
        "-----BEGIN PRIVATE KEY-----\nAAAA\n-----END PRIVATE KEY-----",
        "-----BEGIN EC PRIVATE KEY-----\nMDECAQEE\n-----END EC PRIVATE KEY-----",
        "-----BEGIN EC PRIVATE KEY-----\nMIIB\n-----END EC PRIVATE KEY-----",
        "-----BEGIN EC PRIVATE KEY-----END EC PRIVATE KEY-----",
    }) |pem| {
        try std.testing.expectError(error.LoginCacheInvalid, parseKey(allocator, pem));
    }
    const encoded = "MDECAQEEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABoAoGCCqGSM49AwEH";
    var der: [51]u8 = undefined;
    try std.base64.standard.Decoder.decode(&der, encoded);
    for ([_]usize{ 38, 50 }) |index| {
        var invalid = der;
        invalid[index] = 0;
        var encoded_buffer: [68]u8 = undefined;
        const bad_pem = try std.fmt.allocPrint(
            allocator,
            "-----BEGIN EC PRIVATE KEY-----\n{s}\n-----END EC PRIVATE KEY-----",
            .{std.base64.standard.Encoder.encode(&encoded_buffer, &invalid)},
        );
        try std.testing.expectError(error.LoginCacheInvalid, parseKey(allocator, bad_pem));
    }
}

test "login endpoint uses Sign-In domains for each partition" {
    const cases = [_]struct { region: []const u8, expected: []const u8 }{
        .{ .region = "us-west-2", .expected = "https://us-west-2.signin.aws.amazon.com" },
        .{ .region = "cn-north-1", .expected = "https://cn-north-1.signin.amazonaws.cn" },
        .{
            .region = "us-gov-west-1",
            .expected = "https://us-gov-west-1.signin.amazonaws-us-gov.com",
        },
    };
    for (cases) |case| {
        const actual = try loginEndpoint(std.testing.allocator, case.region);
        defer std.testing.allocator.free(actual);
        try std.testing.expectEqualStrings(case.expected, actual);
    }
}

fn verifyTestProof(allocator: Allocator, proof: []const u8, base: []const u8) !void {
    var parts = std.mem.splitScalar(u8, proof, '.');
    const header_part = parts.next() orelse return error.TestUnexpectedResult;
    const payload_part = parts.next() orelse return error.TestUnexpectedResult;
    const signature_part = parts.next() orelse return error.TestUnexpectedResult;
    try std.testing.expect(parts.next() == null);
    const decoder = std.base64.url_safe_no_pad.Decoder;
    const header_json = try allocator.alloc(u8, try decoder.calcSizeForSlice(header_part));
    try decoder.decode(header_json, header_part);
    const header = try std.json.parseFromSliceLeaky(std.json.Value, allocator, header_json, .{});
    try std.testing.expectEqualStrings("ES256", try stringField(header, "alg"));
    try std.testing.expectEqualStrings("dpop+jwt", try stringField(header, "typ"));
    const jwk = try objectField(header, "jwk");
    try std.testing.expectEqualStrings("EC", try stringField(jwk, "kty"));
    try std.testing.expectEqualStrings("P-256", try stringField(jwk, "crv"));
    var public: [65]u8 = undefined;
    public[0] = 4;
    try decoder.decode(public[1..33], try stringField(jwk, "x"));
    try decoder.decode(public[33..65], try stringField(jwk, "y"));
    const payload_json = try allocator.alloc(u8, try decoder.calcSizeForSlice(payload_part));
    try decoder.decode(payload_json, payload_part);
    const payload = try std.json.parseFromSliceLeaky(std.json.Value, allocator, payload_json, .{});
    try std.testing.expectEqualStrings("POST", try stringField(payload, "htm"));
    try std.testing.expectEqualStrings(
        try std.fmt.allocPrint(allocator, "{s}/v1/token", .{base}),
        try stringField(payload, "htu"),
    );
    try std.testing.expectEqual(@as(usize, 32), (try stringField(payload, "jti")).len);
    try std.testing.expect((try field(payload, "iat")) == .integer);
    const issued_at = (try field(payload, "iat")).integer;
    const now = std.Io.Clock.real.now(std.testing.io).toSeconds();
    try std.testing.expect(issued_at <= now and issued_at >= now - 60);
    var raw_signature: [64]u8 = undefined;
    try decoder.decode(&raw_signature, signature_part);
    const signature = Ecdsa.Signature.fromBytes(raw_signature);
    const key = try Ecdsa.PublicKey.fromSec1(&public);
    const expected_key = (try parseKey(allocator, test_pem)).public_key.toUncompressedSec1();
    try std.testing.expectEqualSlices(u8, &expected_key, &public);
    try signature.verify(proof[0 .. header_part.len + 1 + payload_part.len], key);
}

const LoginTestServer = struct {
    server: std.Io.net.Server,
    request: [8192]u8 = undefined,
    request_len: usize = 0,
    status: u16 = 200,
    body: []const u8 =
        \\{"accessToken":{"accessKeyId":"REFRESHED","secretAccessKey":"refreshed-secret",
        \\"sessionToken":"refreshed-token"},"expiresIn":900,"refreshToken":"rotated-refresh-token"}
    ,

    fn init() !LoginTestServer {
        const address = try std.Io.net.IpAddress.parseIp4("127.0.0.1", 0);
        return .{ .server = try address.listen(std.testing.io, .{}) };
    }

    fn run(self: *LoginTestServer) void {
        var stream = self.server.accept(std.testing.io) catch return;
        defer stream.close(std.testing.io);
        var read_buf: [8192]u8 = undefined;
        var reader = stream.reader(std.testing.io, &read_buf);
        var content_length: usize = 0;
        while (true) {
            const line = reader.interface.takeDelimiterInclusive('\n') catch return;
            if (self.request_len + line.len > self.request.len) return;
            @memcpy(self.request[self.request_len..][0..line.len], line);
            self.request_len += line.len;
            const prefix = "content-length:";
            if (std.ascii.startsWithIgnoreCase(line, prefix)) {
                content_length = std.fmt.parseInt(
                    usize,
                    std.mem.trim(u8, line[prefix.len..], " \r\n"),
                    10,
                ) catch return;
            }
            if (std.mem.eql(u8, line, "\r\n")) break;
        }
        if (self.request_len + content_length > self.request.len) return;
        reader.interface.readSliceAll(
            self.request[self.request_len..][0..content_length],
        ) catch return;
        self.request_len += content_length;
        var write_buf: [2048]u8 = undefined;
        var writer = stream.writer(std.testing.io, &write_buf);
        writer.interface.print(
            "HTTP/1.1 {d} Test\r\nContent-Length: {d}\r\nConnection: close\r\n\r\n{s}",
            .{ self.status, self.body.len, self.body },
        ) catch return;
        writer.interface.flush() catch {};
    }
};

const test_pem =
    \\-----BEGIN EC PRIVATE KEY-----
    \\MDECAQEEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABoAoGCCqGSM49AwEH
    \\-----END EC PRIVATE KEY-----
;

const test_cache =
    \\{
    \\  "accessToken": {
    \\    "accessKeyId": "LOGIN", "secretAccessKey": "login-secret",
    \\    "sessionToken": "login-token", "accountId": "111111111111",
    \\    "expiresAt": "2099-01-01T00:00:00Z"
    \\  },
    \\  "tokenType": "aws_sigv4", "refreshToken": "test-refresh-token",
    \\  "clientId": "test-client", "dpopKey": "test-key", "identityToken": "test-identity"
    \\}
;
