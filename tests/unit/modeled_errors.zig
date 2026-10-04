const std = @import("std");

const aws = @import("aws");
const backupgateway = @import("backupgateway");
const cognitoidentity = @import("cognitoidentity");
const dynamodb = @import("dynamodb");
const lambda = @import("lambda");
const s3 = @import("s3");
const sts = @import("sts");
const verifiedpermissions = @import("verifiedpermissions");

test {
    _ = @import("error_parser.zig");
    _ = @import("generated_clients.zig");
}

const TestServer = struct {
    server: std.Io.net.Server,
    response: []const u8,
    thread: ?std.Thread = null,

    fn init(comptime body: []const u8) !TestServer {
        const loopback = try std.Io.net.IpAddress.parseIp4("127.0.0.1", 0);
        return .{
            .server = try loopback.listen(std.testing.io, .{ .reuse_address = true }),
            .response = std.fmt.comptimePrint(
                "HTTP/1.1 400 Bad Request\r\nContent-Length: {d}\r\n" ++
                    "Connection: close\r\n\r\n{s}",
                .{ body.len, body },
            ),
        };
    }

    fn start(self: *TestServer) !void {
        self.thread = try std.Thread.spawn(.{}, run, .{self});
    }

    fn deinit(self: *TestServer) void {
        self.server.deinit(std.testing.io);
        if (self.thread) |thread| thread.join();
    }

    fn endpoint(self: *const TestServer, buffer: []u8) ![]const u8 {
        return std.fmt.bufPrint(
            buffer,
            "http://127.0.0.1:{d}",
            .{self.server.socket.address.getPort()},
        );
    }

    fn run(self: *TestServer) void {
        var stream = self.server.accept(std.testing.io) catch return;
        defer stream.close(std.testing.io);

        var read_buffer: [16 * 1024]u8 = undefined;
        var reader = stream.reader(std.testing.io, &read_buffer);
        var content_length: usize = 0;
        while (true) {
            const line = reader.interface.takeDelimiterInclusive('\n') catch return;
            if (std.mem.eql(u8, line, "\r\n")) break;
            if (std.mem.startsWith(u8, line, "Content-Length:")) {
                content_length = std.fmt.parseInt(
                    usize,
                    std.mem.trim(u8, line["Content-Length:".len..], " \r\n"),
                    10,
                ) catch return;
            }
        }
        reader.interface.discardAll(content_length) catch return;

        var write_buffer: [4096]u8 = undefined;
        var writer = stream.writer(std.testing.io, &write_buffer);
        writer.interface.writeAll(self.response) catch return;
        writer.interface.flush() catch {};
    }
};

fn makeConfig(env_map: *const std.process.Environ.Map, endpoint: []const u8) !aws.Config {
    return .{
        .allocator = std.testing.allocator,
        .io = std.testing.io,
        .env_map = env_map,
        .region = "us-east-1",
        .endpoint_url = endpoint,
        .credentials = .{ .static = .{
            .access_key_id = "review-test-key",
            .secret_access_key = "review-test-secret",
        } },
        .http_client = try aws.http.HttpClient.init(
            std.testing.allocator,
            std.testing.io,
            env_map,
            .{},
        ),
    };
}

test "omitted required error string has a safe default" {
    var server = try TestServer.init(
        \\{"__type":"AccessDeniedException","Message":"denied"}
    );
    defer server.deinit();
    try server.start();

    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var endpoint_buffer: [64]u8 = undefined;
    var config = try makeConfig(&env_map, try server.endpoint(&endpoint_buffer));
    defer config.http_client.deinit();
    var client = backupgateway.Client.initWithOptions(
        std.testing.allocator,
        &config,
        .{ .max_attempts = 1, .keep_alive = false },
    );
    defer client.deinit();

    var diagnostic: backupgateway.ServiceError = undefined;
    try std.testing.expectError(error.ServiceError, client.getGateway(
        std.testing.allocator,
        .{ .gateway_arn = "missing-gateway" },
        .{ .diagnostic = &diagnostic },
    ));
    defer diagnostic.deinit();
    switch (diagnostic.kind) {
        .access_denied_exception => |value| {
            try std.testing.expectEqual(@as(usize, 0), value.error_code.len);
            try std.testing.expectEqualStrings("", value.error_code);
        },
        else => return error.ExpectedAccessDeniedException,
    }
}

test "null optional message preserves the known error" {
    var server = try TestServer.init(
        \\{"__type":"ResourceNotFoundException","message":null}
    );
    defer server.deinit();
    try server.start();

    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var endpoint_buffer: [64]u8 = undefined;
    var config = try makeConfig(&env_map, try server.endpoint(&endpoint_buffer));
    defer config.http_client.deinit();
    var client = cognitoidentity.Client.initWithOptions(
        std.testing.allocator,
        &config,
        .{ .max_attempts = 1, .keep_alive = false },
    );
    defer client.deinit();

    var diagnostic: cognitoidentity.ServiceError = undefined;
    try std.testing.expectError(error.ServiceError, client.getId(
        std.testing.allocator,
        .{ .identity_pool_id = "missing-identity-pool" },
        .{ .diagnostic = &diagnostic },
    ));
    defer diagnostic.deinit();
    try std.testing.expectEqual(
        .resource_not_found_exception,
        std.meta.activeTag(diagnostic.kind),
    );
}

test "unknown enum value preserves the known error" {
    var server = try TestServer.init(
        \\{"__type":"ResourceNotFoundException","message":"missing",
        \\ "resourceId":"r1","resourceType":"FUTURE_RESOURCE"}
    );
    defer server.deinit();
    try server.start();

    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var endpoint_buffer: [64]u8 = undefined;
    var config = try makeConfig(&env_map, try server.endpoint(&endpoint_buffer));
    defer config.http_client.deinit();
    var client = verifiedpermissions.Client.initWithOptions(
        std.testing.allocator,
        &config,
        .{ .max_attempts = 1, .keep_alive = false },
    );
    defer client.deinit();

    var diagnostic: verifiedpermissions.ServiceError = undefined;
    try std.testing.expectError(error.ServiceError, client.getPolicyStore(
        std.testing.allocator,
        .{ .policy_store_id = "missing-policy-store" },
        .{ .diagnostic = &diagnostic },
    ));
    defer diagnostic.deinit();
    try std.testing.expectEqual(
        .resource_not_found_exception,
        std.meta.activeTag(diagnostic.kind),
    );
    try std.testing.expectEqualStrings(
        "r1",
        diagnostic.kind.resource_not_found_exception.resource_id,
    );
    try std.testing.expect(diagnostic.kind.resource_not_found_exception.resource_type == null);
}

test "a valid error retains modeled map data" {
    var server = try TestServer.init(
        \\{"__type":"ConditionalCheckFailedException","message":"condition failed",
        \\ "Item":{"pk":{"S":"original"}}}
    );
    defer server.deinit();
    try server.start();

    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var endpoint_buffer: [64]u8 = undefined;
    var config = try makeConfig(&env_map, try server.endpoint(&endpoint_buffer));
    defer config.http_client.deinit();
    var client = dynamodb.Client.initWithOptions(
        std.testing.allocator,
        &config,
        .{ .max_attempts = 1, .keep_alive = false },
    );
    defer client.deinit();

    var diagnostic: dynamodb.ServiceError = undefined;
    try std.testing.expectError(error.ServiceError, client.putItem(
        std.testing.allocator,
        .{ .table_name = "review-table", .item = &.{} },
        .{ .diagnostic = &diagnostic },
    ));
    defer diagnostic.deinit();
    switch (diagnostic.kind) {
        .conditional_check_failed_exception => |value| {
            try std.testing.expectEqualStrings("condition failed", value.message);
            const item = value.item orelse return error.ExpectedModeledItem;
            try std.testing.expectEqual(@as(usize, 1), item.len);
            try std.testing.expectEqualStrings("pk", item[0].key);
            try std.testing.expectEqualStrings("original", item[0].value.s.?);
        },
        else => return error.ExpectedConditionalCheckFailedException,
    }
}

fn expectClientDiagnostic(
    comptime service: type,
    comptime operation: []const u8,
    input: anytype,
    comptime body: []const u8,
    expected_tag: []const u8,
    expected_request_id: []const u8,
) !void {
    var server = try TestServer.init(body);
    defer server.deinit();
    try server.start();

    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var endpoint_buffer: [64]u8 = undefined;
    var config = try makeConfig(&env_map, try server.endpoint(&endpoint_buffer));
    defer config.http_client.deinit();
    var client = service.Client.initWithOptions(
        std.testing.allocator,
        &config,
        .{ .max_attempts = 1, .keep_alive = false },
    );
    defer client.deinit();

    var diagnostic: service.ServiceError = undefined;
    try std.testing.expectError(error.ServiceError, @call(
        .auto,
        @field(service.Client, operation),
        .{
            &client,
            std.testing.allocator,
            input,
            service.CallOptions{ .diagnostic = &diagnostic },
        },
    ));
    defer diagnostic.deinit();
    try std.testing.expectEqualStrings(expected_tag, @tagName(diagnostic.kind));
    try std.testing.expectEqualStrings("missing", diagnostic.message());
    try std.testing.expectEqualStrings(expected_request_id, diagnostic.requestId());
}

test "query client uses the shared parser" {
    try expectClientDiagnostic(sts, "getCallerIdentity", sts.GetCallerIdentityInput{},
        \\<ErrorResponse><Error><Code>ExpiredTokenException</Code><Message>missing</Message>
        \\</Error><RequestId>query-request</RequestId></ErrorResponse>
    , "expired_token_exception", "query-request");
}

test "streaming client uses the shared parser" {
    try expectClientDiagnostic(s3, "getObject", s3.GetObjectInput{
        .bucket = "review-bucket",
        .key = "missing-key",
    },
        \\<Error><Code>NoSuchKey</Code><Message>missing</Message><RequestId>xml-request</RequestId>
        \\</Error>
    , "no_such_key", "xml-request");
}

test "event stream client uses the shared parser" {
    try expectClientDiagnostic(
        lambda,
        "invokeWithResponseStream",
        lambda.InvokeWithResponseStreamInput{ .function_name = "missing-function" },
        \\{"__type":"ResourceNotFoundException","message":"missing"}
    ,
        "resource_not_found_exception",
        "",
    );
}
