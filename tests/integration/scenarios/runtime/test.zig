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

    // Get endpoint from environment (set by run.sh)
    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

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
    // Environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
    // are set by run.sh
    const creds = try aws.credentials.getFromEnvironment();
    try std.testing.expectEqualStrings("test", creds.access_key_id);
    try std.testing.expectEqualStrings("test", creds.secret_access_key);
}

test "Config.load resolves region from environment" {
    // AWS_DEFAULT_REGION is set by run.sh
    var cfg = try aws.Config.load(std.testing.allocator, .{});
    defer cfg.deinit();

    try std.testing.expectEqualStrings("us-east-1", cfg.region);
}

test "Config.load with explicit endpoint" {
    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(std.testing.allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    const endpoint = try cfg.getEndpoint("sts", std.testing.allocator);
    defer std.testing.allocator.free(endpoint);

    try std.testing.expectEqualStrings(endpoint_url, endpoint);
}

test "HTTP client connects to LocalStack" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

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
