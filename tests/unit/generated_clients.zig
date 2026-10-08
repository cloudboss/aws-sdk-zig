const std = @import("std");
const aws = @import("aws");
const iotsitewise = @import("iotsitewise");
const lambdacore = @import("lambdacore");
const lambdamicrovms = @import("lambdamicrovms");
const bedrockruntime = @import("bedrockruntime");
const kinesis = @import("kinesis");
const s3 = @import("s3");

// Exported functions compile client calls without sending requests.
comptime {
    for (.{
        .{ iotsitewise, "check_iotsitewise_calls" },
        .{ lambdacore, "check_lambdacore_calls" },
        .{ lambdamicrovms, "check_lambdamicrovms_calls" },
        .{ bedrockruntime, "check_bedrockruntime_calls" },
        .{ kinesis, "check_kinesis_calls" },
    }) |entry| {
        const Checks = ClientCalls(entry[0]);
        @export(&Checks.check, .{ .name = entry[1] });
    }
}

fn ClientCalls(comptime Service: type) type {
    return struct {
        fn check(
            client: *Service.Client,
            allocator: *const std.mem.Allocator,
            input: *const anyopaque,
        ) callconv(.c) void {
            inline for (@typeInfo(Service.Client).@"struct".decl_names) |decl_name| {
                const method = @field(Service.Client, decl_name);
                const info = @typeInfo(@TypeOf(method));
                if (comptime info == .@"fn" and info.@"fn".param_types.len == 4) {
                    const Input = info.@"fn".param_types[2].?;
                    const params: *const Input = @ptrCast(@alignCast(input));
                    _ = method(client, allocator.*, params.*, .{}) catch {};
                }
            }
            inline for (@typeInfo(Service.paginator).@"struct".decl_names) |decl_name| {
                const Paginator = @field(Service.paginator, decl_name);
                const paginator: *Paginator = @ptrCast(@alignCast(@constCast(input)));
                _ = paginator.next(allocator.*, .{}) catch {};
            }
        }
    };
}

const TestServer = struct {
    server: std.Io.net.Server,
    responses: []const []const u8,
    response_headers: []const u8 = "",
    thread: ?std.Thread = null,
    saw_token: bool = false,

    fn init(responses: []const []const u8) !TestServer {
        const loopback = try std.Io.net.IpAddress.parseIp4("127.0.0.1", 0);
        return .{
            .server = try loopback.listen(std.testing.io, .{ .reuse_address = true }),
            .responses = responses,
        };
    }

    fn start(self: *TestServer) !void {
        self.thread = try std.Thread.spawn(.{}, run, .{self});
    }

    fn join(self: *TestServer) void {
        if (self.thread) |thread| thread.join();
        self.thread = null;
    }

    fn deinit(self: *TestServer) void {
        self.server.deinit(std.testing.io);
        self.join();
    }

    fn endpoint(self: *const TestServer, buffer: []u8) ![]const u8 {
        return std.fmt.bufPrint(
            buffer,
            "http://127.0.0.1:{d}",
            .{self.server.socket.address.getPort()},
        );
    }

    fn run(self: *TestServer) void {
        for (self.responses) |body| {
            var stream = self.server.accept(std.testing.io) catch return;
            defer stream.close(std.testing.io);

            var read_buffer: [16 * 1024]u8 = undefined;
            var reader = stream.reader(std.testing.io, &read_buffer);
            var content_length: usize = 0;
            while (true) {
                const line = reader.interface.takeDelimiterInclusive('\n') catch return;
                if (std.mem.eql(u8, line, "\r\n")) break;
                if (std.mem.indexOf(u8, line, "page-2") != null) self.saw_token = true;
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
            writer.interface.print(
                "HTTP/1.1 200 OK\r\nContent-Length: {d}\r\n",
                .{body.len},
            ) catch return;
            writer.interface.writeAll(self.response_headers) catch return;
            writer.interface.writeAll(
                "Content-Type: application/json\r\nConnection: close\r\n\r\n",
            ) catch return;
            writer.interface.writeAll(body) catch return;
            writer.interface.flush() catch return;
        }
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
            .access_key_id = "test-key",
            .secret_access_key = "test-secret",
        } },
        .http_client = try aws.http.HttpClient.init(
            std.testing.allocator,
            std.testing.io,
            env_map,
            .{},
        ),
    };
}

const TokenAllocator = struct {
    token_len: usize,
    denied: usize = 0,

    fn allocator(self: *TokenAllocator) std.mem.Allocator {
        return .{
            .ptr = self,
            .vtable = &.{
                .alloc = alloc,
                .resize = std.mem.Allocator.noResize,
                .remap = std.mem.Allocator.noRemap,
                .free = free,
            },
        };
    }

    fn alloc(
        context: *anyopaque,
        len: usize,
        alignment: std.mem.Alignment,
        return_address: usize,
    ) ?[*]u8 {
        const self: *TokenAllocator = @ptrCast(@alignCast(context));
        if (len == self.token_len) {
            self.denied += 1;
            return null;
        }
        return std.testing.allocator.rawAlloc(len, alignment, return_address);
    }

    fn free(
        context: *anyopaque,
        memory: []u8,
        alignment: std.mem.Alignment,
        return_address: usize,
    ) void {
        _ = context;
        std.testing.allocator.rawFree(memory, alignment, return_address);
    }
};

test "required response payload and headers are initialized" {
    const body = "{\"ok\":true}";
    var server = try TestServer.init(&.{body});
    defer server.deinit();
    try server.start();

    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var endpoint_buffer: [64]u8 = undefined;
    var config = try makeConfig(&env_map, try server.endpoint(&endpoint_buffer));
    defer config.http_client.deinit();
    var client = bedrockruntime.Client.initWithOptions(
        std.testing.allocator,
        &config,
        .{ .max_attempts = 1, .keep_alive = false },
    );
    defer client.deinit();

    const output = try client.invokeModel(
        std.testing.allocator,
        .{ .model_id = "example", .body = "{}" },
        .{},
    );
    defer std.testing.allocator.free(output.body);
    defer std.testing.allocator.free(output.content_type);
    try std.testing.expectEqualStrings(body, output.body);
    try std.testing.expectEqualStrings("application/json", output.content_type);
}

test "new Lambda clients decode required response members" {
    const cases = .{
        .{
            lambdacore,
            "getNetworkConnector",
            lambdacore.GetNetworkConnectorInput{ .identifier = "connector-1" },
            \\{"Arn":"arn:connector","Id":"connector-1","Name":"example"}
            ,
            .{
                .{ "arn", "arn:connector" },
                .{ "id", "connector-1" },
                .{ "name", "example" },
                .{ "configuration", null },
            },
        },
        .{
            lambdamicrovms,
            "getMicrovm",
            lambdamicrovms.GetMicrovmInput{ .microvm_identifier = "vm-1" },
            \\{"endpoint":"https://example.com","imageArn":"arn:image","imageVersion":"1",
            \\ "maximumDurationInSeconds":3600,"microvmId":"vm-1","startedAt":123,"state":"RUNNING"}
            ,
            .{
                .{ "endpoint", "https://example.com" },
                .{ "image_arn", "arn:image" },
                .{ "image_version", "1" },
                .{ "maximum_duration_in_seconds", 3600 },
                .{ "microvm_id", "vm-1" },
                .{ "started_at", 123 },
                .{ "state", .running },
            },
        },
        .{
            lambdacore,
            "getNetworkConnector",
            lambdacore.GetNetworkConnectorInput{ .identifier = "connector-1" },
            "",
            .{ .{ "arn", "" }, .{ "id", "" }, .{ "name", "" }, .{ "configuration", null } },
        },
    };
    inline for (cases) |case| {
        const Service = case[0];
        var server = try TestServer.init(&.{case[3]});
        defer server.deinit();
        try server.start();

        var env_map: std.process.Environ.Map = .init(std.testing.allocator);
        defer env_map.deinit();
        var endpoint_buffer: [64]u8 = undefined;
        var config = try makeConfig(&env_map, try server.endpoint(&endpoint_buffer));
        defer config.http_client.deinit();
        var client = Service.Client.initWithOptions(
            std.testing.allocator,
            &config,
            .{ .max_attempts = 1, .keep_alive = false },
        );
        defer client.deinit();

        var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
        defer arena.deinit();
        const output = try @field(Service.Client, case[1])(
            &client,
            arena.allocator(),
            case[2],
            .{},
        );
        inline for (case[4]) |expected| {
            const value = @field(output, expected[0]);
            try std.testing.expectEqualDeep(@as(@TypeOf(value), expected[1]), value);
        }
    }
}

test "empty response reports a missing required enum" {
    var server = try TestServer.init(&.{""});
    defer server.deinit();
    try server.start();

    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var endpoint_buffer: [64]u8 = undefined;
    var config = try makeConfig(&env_map, try server.endpoint(&endpoint_buffer));
    defer config.http_client.deinit();
    var client = lambdamicrovms.Client.initWithOptions(
        std.testing.allocator,
        &config,
        .{ .max_attempts = 1, .keep_alive = false },
    );
    defer client.deinit();

    try std.testing.expectError(error.MissingField, client.getMicrovm(
        std.testing.allocator,
        .{ .microvm_identifier = "vm-1" },
        .{},
    ));
}

test "event stream response preserves the conversation ID" {
    var server = try TestServer.init(&.{""});
    server.response_headers = "x-amz-iotsitewise-assistant-conversation-id: conversation-1\r\n";
    defer server.deinit();
    try server.start();

    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var endpoint_buffer: [64]u8 = undefined;
    var config = try makeConfig(&env_map, try server.endpoint(&endpoint_buffer));
    defer config.http_client.deinit();
    var client = iotsitewise.Client.initWithOptions(
        std.testing.allocator,
        &config,
        .{ .max_attempts = 1, .keep_alive = false },
    );
    defer client.deinit();

    var output = try client.invokeAssistant(std.testing.allocator, .{ .message = "test" }, .{});
    defer output.deinit();
    defer std.testing.allocator.free(output.conversation_id);
    try std.testing.expectEqualStrings("conversation-1", output.conversation_id);
    try std.testing.expectEqual(null, try output.body.next());
}

test "event stream allocation failure frees metadata and closes the response" {
    inline for (.{ 0, 1 }) |fail_index| {
        var server = try TestServer.init(&.{""});
        server.response_headers = "x-amz-iotsitewise-assistant-conversation-id: conversation-1\r\n";
        defer server.deinit();
        try server.start();

        var env_map: std.process.Environ.Map = .init(std.testing.allocator);
        defer env_map.deinit();
        var endpoint_buffer: [64]u8 = undefined;
        var config = try makeConfig(&env_map, try server.endpoint(&endpoint_buffer));
        defer config.http_client.deinit();
        var client = iotsitewise.Client.initWithOptions(
            std.testing.allocator,
            &config,
            .{ .max_attempts = 1, .keep_alive = false },
        );
        defer client.deinit();

        var failing = std.testing.FailingAllocator.init(
            std.testing.allocator,
            .{ .fail_index = fail_index },
        );
        try std.testing.expectError(error.OutOfMemory, client.invokeAssistant(
            failing.allocator(),
            .{ .message = "test" },
            .{},
        ));
        try std.testing.expect(failing.has_induced_failure);
        try std.testing.expectEqual(failing.allocated_bytes, failing.freed_bytes);
    }
}

test "AWS JSON and REST XML event streams retain their bodies" {
    const cases = .{
        .{
            kinesis,
            "subscribeToShard",
            kinesis.SubscribeToShardInput{
                .consumer_arn = "arn:consumer",
                .shard_id = "shard-1",
                .starting_position = .{ .type = .latest },
            },
            "event_stream",
        },
        .{
            s3,
            "selectObjectContent",
            s3.SelectObjectContentInput{
                .bucket = "example",
                .key = "data.csv",
                .expression = "SELECT * FROM S3Object",
                .expression_type = .sql,
                .input_serialization = .{ .csv = .{} },
                .output_serialization = .{ .csv = .{} },
            },
            "payload",
        },
    };
    inline for (cases) |case| {
        const Service = case[0];
        var server = try TestServer.init(&.{""});
        defer server.deinit();
        try server.start();

        var env_map: std.process.Environ.Map = .init(std.testing.allocator);
        defer env_map.deinit();
        var endpoint_buffer: [64]u8 = undefined;
        var config = try makeConfig(&env_map, try server.endpoint(&endpoint_buffer));
        defer config.http_client.deinit();
        var client = Service.Client.initWithOptions(
            std.testing.allocator,
            &config,
            .{ .max_attempts = 1, .keep_alive = false },
        );
        defer client.deinit();

        var output = try @field(Service.Client, case[1])(
            &client,
            std.testing.allocator,
            case[2],
            .{},
        );
        defer output.deinit();
        try std.testing.expectEqual(null, try @field(output, case[3]).next());
    }
}

test "paginators own tokens and stop on null or empty values" {
    const required_input: iotsitewise.ListActionsInput = .{
        .target_resource_id = "asset-1",
        .target_resource_type = .asset,
    };
    const cases = .{
        .{
            iotsitewise,                  "listActionsPaginator", required_input, "next_token",
            "{\"nextToken\":\"page-2\"}", "{\"nextToken\":null}",
        },
        .{
            iotsitewise,                  "listActionsPaginator", required_input, "next_token",
            "{\"nextToken\":\"page-2\"}", "{\"nextToken\":\"\"}",
        },
        .{
            iotsitewise,                  "listActionsPaginator", required_input, "next_token",
            "{\"nextToken\":\"page-2\"}", "{}",
        },
        .{
            lambdacore,                              "listNetworkConnectorsPaginator",
            lambdacore.ListNetworkConnectorsInput{}, "next_marker",
            "{\"NextMarker\":\"page-2\"}",           "{\"NextMarker\":\"\"}",
        },
        .{
            lambdacore,                              "listNetworkConnectorsPaginator",
            lambdacore.ListNetworkConnectorsInput{}, "next_marker",
            "{\"NextMarker\":\"page-2\"}",           "{\"NextMarker\":null}",
        },
    };
    inline for (cases) |case| {
        const Service = case[0];
        var server = try TestServer.init(&.{ case[4], case[5] });
        defer server.deinit();
        try server.start();

        var env_map: std.process.Environ.Map = .init(std.testing.allocator);
        defer env_map.deinit();
        var endpoint_buffer: [64]u8 = undefined;
        var config = try makeConfig(&env_map, try server.endpoint(&endpoint_buffer));
        defer config.http_client.deinit();
        var client = Service.Client.initWithOptions(
            std.testing.allocator,
            &config,
            .{ .max_attempts = 1, .keep_alive = false },
        );
        defer client.deinit();
        var paginator = @field(Service.Client, case[1])(&client, case[2]);
        defer paginator.deinit();

        {
            var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
            defer arena.deinit();
            const page = try paginator.next(arena.allocator(), .{});
            const token: ?[]const u8 = @field(page, case[3]);
            try std.testing.expectEqualStrings("page-2", token.?);
        }
        try std.testing.expectEqualStrings("page-2", paginator.next_token.?);
        {
            var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
            defer arena.deinit();
            _ = try paginator.next(arena.allocator(), .{});
        }
        server.join();
        try std.testing.expect(server.saw_token);
        try std.testing.expect(paginator.done);
        try std.testing.expectEqual(null, paginator.next_token);
        try std.testing.expectError(
            error.EndOfPagination,
            paginator.next(std.testing.allocator, .{}),
        );
    }
}

test "pagination allocation failure preserves the previous token" {
    const token: [4093]u8 = @splat('t');
    var server = try TestServer.init(&.{
        "{\"NextMarker\":\"" ++ token ++ "\"}",
        "{\"NextMarker\":null}",
    });
    defer server.deinit();
    try server.start();

    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var endpoint_buffer: [64]u8 = undefined;
    var config = try makeConfig(&env_map, try server.endpoint(&endpoint_buffer));
    defer config.http_client.deinit();
    var failing: TokenAllocator = .{ .token_len = token.len };
    var client = lambdacore.Client.initWithOptions(
        failing.allocator(),
        &config,
        .{ .max_attempts = 1, .keep_alive = false },
    );
    defer client.deinit();
    var paginator = client.listNetworkConnectorsPaginator(.{});
    paginator.next_token = try client.allocator.dupe(u8, "previous");
    defer paginator.deinit();

    {
        var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
        defer arena.deinit();
        try std.testing.expectError(error.OutOfMemory, paginator.next(arena.allocator(), .{}));
    }
    try std.testing.expectEqual(@as(usize, 1), failing.denied);
    try std.testing.expectEqualStrings("previous", paginator.next_token.?);
    try std.testing.expect(!paginator.done);
    {
        var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
        defer arena.deinit();
        _ = try paginator.next(arena.allocator(), .{});
    }
    try std.testing.expect(paginator.done);
    try std.testing.expectEqual(null, paginator.next_token);
}
