const std = @import("std");
const aws = @import("aws");

const bucket_name = "sdk-zig-gzip-test";

var gpa: std.heap.DebugAllocator(.{}) = .init;
var shared_cfg: aws.Config = undefined;
var shared_env_map: std.process.Environ.Map = undefined;
var shared_init = false;
test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_env_map = try std.process.Environ.createMap(std.testing.environ, allocator);
    shared_cfg = try aws.Config.load(allocator, std.testing.io, &shared_env_map, .{});
    {
        var arena = std.heap.ArenaAllocator.init(allocator);
        defer arena.deinit();

        var request = try makePutObjectRequest(
            arena.allocator(),
            &shared_cfg,
            "/",
            "",
        );
        defer request.deinit(arena.allocator());

        request.path = "/" ++ bucket_name;
        request.query = "x-id=CreateBucket";

        const creds = try shared_cfg.credentials.getCredentials(
            arena.allocator(),
        );
        try aws.signing.signRequest(
            arena.allocator(),
            std.testing.io,
            &request,
            creds,
            shared_cfg.region,
            "s3",
        );

        var response = try shared_cfg.http_client.sendRequestWithOptions(&request, .{ .keep_alive = false });
        defer response.deinit();
        try std.testing.expect(response.isSuccess());
    }
    shared_init = true;
}

test "zest.afterAll" {
    if (!shared_init) {
        _ = gpa.deinit();
        return;
    }
    const allocator = gpa.allocator();
    {
        var arena = std.heap.ArenaAllocator.init(allocator);
        defer arena.deinit();

        const creds = try shared_cfg.credentials.getCredentials(arena.allocator());

        const objects = [_][]const u8{
            "/" ++ bucket_name ++ "/test-object.bin",
            "/" ++ bucket_name ++ "/test-object-plain.bin",
            "/" ++ bucket_name ++ "/test-object-small.bin",
        };
        for (objects) |obj_path| {
            var req = try makePutObjectRequest(arena.allocator(), &shared_cfg, obj_path, "");
            defer req.deinit(arena.allocator());
            req.method = .DELETE;
            req.query = "x-id=DeleteObject";
            try aws.signing.signRequest(
                arena.allocator(),
                std.testing.io,
                &req,
                creds,
                shared_cfg.region,
                "s3",
            );
            var resp = try shared_cfg.http_client.sendRequestWithOptions(&req, .{ .keep_alive = false });
            defer resp.deinit();
            _ = resp.isSuccess();
        }

        var request = try makePutObjectRequest(
            arena.allocator(),
            &shared_cfg,
            "/",
            "",
        );
        defer request.deinit(arena.allocator());

        request.method = .DELETE;
        request.path = "/" ++ bucket_name;
        request.query = "x-id=DeleteBucket";

        try aws.signing.signRequest(
            arena.allocator(),
            std.testing.io,
            &request,
            creds,
            shared_cfg.region,
            "s3",
        );

        var response = try shared_cfg.http_client.sendRequestWithOptions(&request, .{ .keep_alive = false });
        defer response.deinit();
        try std.testing.expect(response.isSuccess());
    }
    shared_cfg.deinit();
    shared_env_map.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "PutObject with gzip compression sends smaller body and sets Content-Encoding" {
    const allocator = gpa.allocator();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const body = try arena.allocator().alloc(u8, 2000);
    @memset(body, 'a');

    var request = try makePutObjectRequest(
        arena.allocator(),
        &shared_cfg,
        "/" ++ bucket_name ++ "/test-object.bin",
        body,
    );
    defer request.deinit(arena.allocator());
    request.request_compression = .gzip;

    const creds = try shared_cfg.credentials.getCredentials(
        arena.allocator(),
    );
    try aws.signing.signRequest(
        arena.allocator(),
        std.testing.io,
        &request,
        creds,
        shared_cfg.region,
        "s3",
    );

    const body_after = request.body orelse return error.MissingBody;
    try std.testing.expect(body_after.len < 2000);
    const encoding = request.headers.get("content-encoding") orelse
        return error.MissingContentEncoding;
    try std.testing.expectEqualStrings("gzip", encoding);

    var response = try shared_cfg.http_client.sendRequestWithOptions(&request, .{ .keep_alive = false });
    defer response.deinit();
    try std.testing.expect(response.isSuccess());
}

test "PutObject without compression sends full body" {
    const allocator = gpa.allocator();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const body = try arena.allocator().alloc(u8, 2000);
    @memset(body, 'b');

    var request = try makePutObjectRequest(
        arena.allocator(),
        &shared_cfg,
        "/" ++ bucket_name ++ "/test-object-plain.bin",
        body,
    );
    defer request.deinit(arena.allocator());

    const creds = try shared_cfg.credentials.getCredentials(
        arena.allocator(),
    );
    try aws.signing.signRequest(
        arena.allocator(),
        std.testing.io,
        &request,
        creds,
        shared_cfg.region,
        "s3",
    );

    const body_after = request.body orelse return error.MissingBody;
    try std.testing.expectEqual(@as(usize, 2000), body_after.len);
    try std.testing.expect(
        request.headers.get("content-encoding") == null,
    );

    var response = try shared_cfg.http_client.sendRequestWithOptions(&request, .{ .keep_alive = false });
    defer response.deinit();
    try std.testing.expect(response.isSuccess());
}

test "PutObject small body skips compression" {
    const allocator = gpa.allocator();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const body = try arena.allocator().alloc(u8, 200);
    @memset(body, 'c');

    var request = try makePutObjectRequest(
        arena.allocator(),
        &shared_cfg,
        "/" ++ bucket_name ++ "/test-object-small.bin",
        body,
    );
    defer request.deinit(arena.allocator());
    request.request_compression = .gzip;

    const creds = try shared_cfg.credentials.getCredentials(
        arena.allocator(),
    );
    try aws.signing.signRequest(
        arena.allocator(),
        std.testing.io,
        &request,
        creds,
        shared_cfg.region,
        "s3",
    );

    const body_after = request.body orelse return error.MissingBody;
    try std.testing.expectEqual(@as(usize, 200), body_after.len);
    try std.testing.expect(
        request.headers.get("content-encoding") == null,
    );

    var response = try shared_cfg.http_client.sendRequestWithOptions(&request, .{ .keep_alive = false });
    defer response.deinit();
    try std.testing.expect(response.isSuccess());
}

fn makePutObjectRequest(
    allocator: std.mem.Allocator,
    cfg: *aws.Config,
    path: []const u8,
    body: []const u8,
) !aws.http.Request {
    const endpoint = try cfg.getEndpointForService("s3", "S3", allocator);
    const ep = try aws.url.parseEndpoint(endpoint);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.tls = ep.tls;
    request.port = ep.port;
    request.path = path;
    request.query = "x-id=PutObject";
    request.body = body;
    try request.headers.put(
        allocator,
        "Content-Type",
        "application/octet-stream",
    );
    return request;
}
