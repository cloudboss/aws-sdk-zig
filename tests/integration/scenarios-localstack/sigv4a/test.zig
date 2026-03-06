const std = @import("std");
const aws = @import("aws");

test "GetCallerIdentity with SigV4a signing succeeds" {
    const allocator = std.testing.allocator;

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();

    var http_client = aws.http.HttpClient.init(allocator, .{});
    defer http_client.deinit();

    var request = try makeGetCallerIdentityRequest(arena.allocator(), &cfg);
    defer request.deinit(arena.allocator());
    request.signing_algorithm = .sigv4a;

    const creds = try cfg.credentials.getCredentials(arena.allocator());
    try aws.signing.signRequest(
        arena.allocator(),
        &request,
        creds,
        cfg.region,
        "sts",
    );

    const auth = request.headers.get("authorization") orelse
        return error.MissingAuthorization;
    try std.testing.expect(
        std.mem.startsWith(u8, auth, "AWS4-ECDSA-P256-SHA256"),
    );
    try std.testing.expect(
        std.mem.indexOf(u8, auth, "/*/sts/aws4_request") != null,
    );

    var response = try http_client.sendRequest(&request);
    defer response.deinit();
    try std.testing.expect(response.isSuccess());
}

test "SigV4a Authorization header has correct format" {
    const allocator = std.testing.allocator;

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    var cfg = try aws.Config.load(allocator, .{});
    defer cfg.deinit();

    var request = try makeGetCallerIdentityRequest(arena.allocator(), &cfg);
    defer request.deinit(arena.allocator());
    request.signing_algorithm = .sigv4a;

    const creds = try cfg.credentials.getCredentials(arena.allocator());
    try aws.signing.signRequest(
        arena.allocator(),
        &request,
        creds,
        cfg.region,
        "sts",
    );

    const auth = request.headers.get("authorization") orelse
        return error.MissingAuthorization;
    try std.testing.expect(
        std.mem.startsWith(u8, auth, "AWS4-ECDSA-P256-SHA256"),
    );

    const date = try readSigv4aDate(arena.allocator(), auth);
    defer arena.allocator().free(date);

    const expected_scope = try std.fmt.allocPrint(
        arena.allocator(),
        "Credential=test/{s}/*/sts/aws4_request",
        .{date},
    );
    try std.testing.expect(std.mem.indexOf(u8, auth, expected_scope) != null);
    try std.testing.expect(
        std.mem.indexOf(u8, auth, "SignedHeaders=") != null,
    );

    const signature = try readSignature(arena.allocator(), auth);
    defer arena.allocator().free(signature);
    try std.testing.expectEqual(@as(usize, 128), signature.len);
    for (signature) |value| {
        try std.testing.expect(isLowerHex(value));
    }
}

fn makeGetCallerIdentityRequest(
    allocator: std.mem.Allocator,
    cfg: *aws.Config,
) !aws.http.Request {
    const endpoint = try cfg.getEndpointForService("sts", "STS", allocator);
    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.tls = tls;
    request.port = port;
    request.path = "/";
    request.body = "Action=GetCallerIdentity&Version=2011-06-15";
    try request.headers.put(
        allocator,
        "Content-Type",
        "application/x-www-form-urlencoded",
    );
    return request;
}

fn readSigv4aDate(
    allocator: std.mem.Allocator,
    auth: []const u8,
) ![]const u8 {
    const marker = "Credential=test/";
    const start_index = std.mem.indexOf(u8, auth, marker) orelse
        return error.InvalidAuthorization;
    const date_start = start_index + marker.len;
    if (auth.len < date_start + 8) {
        return error.InvalidAuthorization;
    }
    return allocator.dupe(u8, auth[date_start .. date_start + 8]);
}

fn readSignature(
    allocator: std.mem.Allocator,
    auth: []const u8,
) ![]const u8 {
    const marker = "Signature=";
    const start_index = std.mem.indexOf(u8, auth, marker) orelse
        return error.InvalidAuthorization;
    const sig_start = start_index + marker.len;
    const sig_end = std.mem.indexOfPos(u8, auth, sig_start, ",") orelse auth.len;
    return allocator.dupe(u8, auth[sig_start..sig_end]);
}

fn isLowerHex(value: u8) bool {
    return (value >= '0' and value <= '9') or (value >= 'a' and value <= 'f');
}
