const std = @import("std");
const aws = @import("aws");

/// Parse host and port from an endpoint URL like "http://localhost:4566"
fn parseEndpoint(url: []const u8) struct { host: []const u8, port: ?u16, tls: bool } {
    var rest = url;
    var tls = true;

    if (std.mem.startsWith(u8, rest, "https://")) {
        rest = rest["https://".len..];
    } else if (std.mem.startsWith(u8, rest, "http://")) {
        rest = rest["http://".len..];
        tls = false;
    }

    if (std.mem.indexOfScalar(u8, rest, ':')) |colon| {
        return .{
            .host = rest[0..colon],
            .port = std.fmt.parseInt(u16, rest[colon + 1 ..], 10) catch null,
            .tls = tls,
        };
    }

    return .{ .host = rest, .port = null, .tls = tls };
}

test "SigV4 signed request accepted by STS" {
    const allocator = std.testing.allocator;

    // Use arena for signing allocations (signing puts owned strings into headers)
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const sign_alloc = arena.allocator();

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();
    const endpoint_url = try cfg.getEndpoint("sts", allocator);
    defer allocator.free(endpoint_url);
    const endpoint = parseEndpoint(endpoint_url);

    // Build a GetCallerIdentity request
    const body = "Action=GetCallerIdentity&Version=2011-06-15";

    var request = aws.http.Request.init(endpoint.host);
    defer request.deinit(sign_alloc);

    request.method = .POST;
    request.path = "/";
    request.tls = endpoint.tls;
    request.port = endpoint.port;
    request.body = body;

    try request.headers.put(sign_alloc, "content-type", "application/x-www-form-urlencoded");

    // Sign with test credentials
    const creds = aws.Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
    };
    try aws.signing.signRequest(sign_alloc, &request, creds, "us-east-1", "sts");

    // Send the request
    var client = aws.http.HttpClient.initWithOptions(allocator, .{ .keep_alive = false });
    defer client.deinit();

    var response = try client.sendRequest(&request);
    defer response.deinit();

    // Verify success
    try std.testing.expect(response.isSuccess());
    // Response should contain GetCallerIdentityResult
    try std.testing.expect(std.mem.indexOf(u8, response.body, "GetCallerIdentityResult") != null);
}

test "credential chain resolves from environment" {
    const creds = try aws.credentials.getFromEnvironment();
    try std.testing.expectEqualStrings("test", creds.access_key_id);
    try std.testing.expectEqualStrings("test", creds.secret_access_key);
}

test "Config.load resolves region from environment" {
    var cfg = try aws.Config.load(std.testing.allocator, .{});
    defer cfg.deinit();

    try std.testing.expectEqualStrings("us-east-1", cfg.region);
}

test "Config.load with explicit endpoint" {
    var cfg = try aws.Config.load(std.testing.allocator, .{});
    defer cfg.deinit();

    const endpoint = try cfg.getEndpoint("sts", std.testing.allocator);
    defer std.testing.allocator.free(endpoint);

    try std.testing.expect(endpoint.len > 0);
}

test "HTTP client connects to LocalStack" {
    const allocator = std.testing.allocator;

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();
    const endpoint_url = try cfg.getEndpoint("sts", allocator);
    defer allocator.free(endpoint_url);
    const endpoint = parseEndpoint(endpoint_url);

    // Simple GET to LocalStack health endpoint
    var request = aws.http.Request.init(endpoint.host);
    defer request.deinit(allocator);

    request.method = .GET;
    request.path = "/_localstack/health";
    request.tls = endpoint.tls;
    request.port = endpoint.port;

    var client = aws.http.HttpClient.initWithOptions(allocator, .{ .keep_alive = false });
    defer client.deinit();

    var response = try client.sendRequest(&request);
    defer response.deinit();

    try std.testing.expect(response.isSuccess());
}

test "SigV4 signing includes session token header when present" {
    const allocator = std.testing.allocator;

    // Use arena for signing allocations (signing puts owned strings into headers)
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const sign_alloc = arena.allocator();

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();
    const endpoint_url = try cfg.getEndpoint("sts", allocator);
    defer allocator.free(endpoint_url);
    const endpoint = parseEndpoint(endpoint_url);

    // Build a GetCallerIdentity request
    const body = "Action=GetCallerIdentity&Version=2011-06-15";

    var request = aws.http.Request.init(endpoint.host);
    defer request.deinit(sign_alloc);

    request.method = .POST;
    request.path = "/";
    request.tls = endpoint.tls;
    request.port = endpoint.port;
    request.body = body;

    try request.headers.put(sign_alloc, "content-type", "application/x-www-form-urlencoded");

    // Sign with test credentials that include a session token
    const creds = aws.Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
        .session_token = "test-session-token",
    };
    try aws.signing.signRequest(sign_alloc, &request, creds, "us-east-1", "sts");

    // Verify the session token header was added
    const token_header = request.headers.get("x-amz-security-token");
    try std.testing.expect(token_header != null);
    try std.testing.expectEqualStrings("test-session-token", token_header.?);

    // Send the request to verify LocalStack accepts it
    var client = aws.http.HttpClient.initWithOptions(allocator, .{ .keep_alive = false });
    defer client.deinit();

    var response = try client.sendRequest(&request);
    defer response.deinit();

    // Verify success
    try std.testing.expect(response.isSuccess());
    // Response should contain GetCallerIdentityResult
    try std.testing.expect(std.mem.indexOf(u8, response.body, "GetCallerIdentityResult") != null);
}

test "SigV4 signature includes x-amz-date header" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const sign_alloc = arena.allocator();

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();
    const endpoint_url = try cfg.getEndpoint("sts", allocator);
    defer allocator.free(endpoint_url);
    const endpoint = parseEndpoint(endpoint_url);

    var request = aws.http.Request.init(endpoint.host);
    defer request.deinit(sign_alloc);
    request.method = .POST;
    request.path = "/";
    request.tls = endpoint.tls;
    request.port = endpoint.port;
    request.body = "Action=GetCallerIdentity&Version=2011-06-15";
    try request.headers.put(sign_alloc, "content-type", "application/x-www-form-urlencoded");

    const creds = aws.Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
    };
    try aws.signing.signRequest(sign_alloc, &request, creds, "us-east-1", "sts");

    // x-amz-date format: YYYYMMDDTHHMMSSZ = 16 characters
    const date_header = request.headers.get("x-amz-date");
    try std.testing.expect(date_header != null);
    try std.testing.expectEqual(@as(usize, 16), date_header.?.len);
}

test "SigV4 signature includes x-amz-content-sha256 header" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const sign_alloc = arena.allocator();

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();
    const endpoint_url = try cfg.getEndpoint("sts", allocator);
    defer allocator.free(endpoint_url);
    const endpoint = parseEndpoint(endpoint_url);

    var request = aws.http.Request.init(endpoint.host);
    defer request.deinit(sign_alloc);
    request.method = .POST;
    request.path = "/";
    request.tls = endpoint.tls;
    request.port = endpoint.port;
    request.body = "Action=GetCallerIdentity&Version=2011-06-15";
    try request.headers.put(sign_alloc, "content-type", "application/x-www-form-urlencoded");

    const creds = aws.Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
    };
    try aws.signing.signRequest(sign_alloc, &request, creds, "us-east-1", "sts");

    // SHA-256 hex digest = 64 characters
    const sha256_header = request.headers.get("x-amz-content-sha256");
    try std.testing.expect(sha256_header != null);
    try std.testing.expectEqual(@as(usize, 64), sha256_header.?.len);
}

test "SigV4 Authorization header starts with AWS4-HMAC-SHA256" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const sign_alloc = arena.allocator();

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();
    const endpoint_url = try cfg.getEndpoint("sts", allocator);
    defer allocator.free(endpoint_url);
    const endpoint = parseEndpoint(endpoint_url);

    var request = aws.http.Request.init(endpoint.host);
    defer request.deinit(sign_alloc);
    request.method = .POST;
    request.path = "/";
    request.tls = endpoint.tls;
    request.port = endpoint.port;
    request.body = "Action=GetCallerIdentity&Version=2011-06-15";
    try request.headers.put(sign_alloc, "content-type", "application/x-www-form-urlencoded");

    const creds = aws.Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
    };
    try aws.signing.signRequest(sign_alloc, &request, creds, "us-east-1", "sts");

    const auth_header = request.headers.get("authorization");
    try std.testing.expect(auth_header != null);
    try std.testing.expect(std.mem.startsWith(u8, auth_header.?, "AWS4-HMAC-SHA256 "));
}

test "SigV4 signed GET request with empty body succeeds" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const sign_alloc = arena.allocator();

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();
    const endpoint_url = try cfg.getEndpoint("sts", allocator);
    defer allocator.free(endpoint_url);
    const endpoint = parseEndpoint(endpoint_url);

    var request = aws.http.Request.init(endpoint.host);
    defer request.deinit(sign_alloc);
    request.method = .GET;
    request.path = "/_localstack/health";
    request.tls = endpoint.tls;
    request.port = endpoint.port;

    const creds = aws.Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
    };
    try aws.signing.signRequest(sign_alloc, &request, creds, "us-east-1", "s3");

    var client = aws.http.HttpClient.initWithOptions(allocator, .{ .keep_alive = false });
    defer client.deinit();
    var response = try client.sendRequest(&request);
    defer response.deinit();

    try std.testing.expect(response.isSuccess());
}
