const std = @import("std");
const aws = @import("aws");
const kinesis = @import("kinesis");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: kinesis.Client = undefined;
var shared_cfg: aws.Config = undefined;
var shared_init = false;
var stream_name_buf: [64]u8 = undefined;
var stream_name: []const u8 = "";
var stream_arn_buf: [256]u8 = undefined;
var stream_arn: []const u8 = "";
var consumer_arn_buf: [256]u8 = undefined;
var consumer_arn: []const u8 = "";

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = kinesis.Client.initWithOptions(
        allocator,
        &shared_cfg,
        .{ .keep_alive = false },
    );

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    stream_name = try std.fmt.bufPrint(
        &stream_name_buf,
        "sdk-zig-live-kinesis-{d}",
        .{std.time.timestamp()},
    );

    _ = try shared_client.createStream(
        arena.allocator(),
        .{
            .stream_name = stream_name,
            .shard_count = 1,
        },
        .{},
    );

    // Poll for ACTIVE status (2s intervals, up to 60s)
    var attempts: u32 = 0;
    while (attempts < 30) : (attempts += 1) {
        const desc = try shared_client.describeStreamSummary(
            arena.allocator(),
            .{ .stream_name = stream_name },
            .{},
        );
        const summary = desc.stream_description_summary orelse
            continue;
        if (summary.stream_status == .active) {
            const arn = summary.stream_arn;
            const len = @min(arn.len, stream_arn_buf.len);
            @memcpy(stream_arn_buf[0..len], arn[0..len]);
            stream_arn = stream_arn_buf[0..len];
            break;
        }
        std.Thread.sleep(2 * std.time.ns_per_s);
    }
    if (stream_arn.len == 0) return error.StreamNotActive;

    _ = try shared_client.addTagsToStream(
        arena.allocator(),
        .{
            .stream_name = stream_name,
            .tags = &.{
                .{
                    .key = "aws-sdk-zig-test",
                    .value = "true",
                },
                .{
                    .key = "created-by",
                    .value = "integration-test",
                },
            },
        },
        .{},
    );

    shared_init = true;
}

test "zest.afterAll" {
    if (!shared_init) {
        _ = gpa.deinit();
        return;
    }
    {
        var arena = std.heap.ArenaAllocator.init(gpa.allocator());
        defer arena.deinit();

        if (consumer_arn.len > 0) {
            _ = shared_client.deregisterStreamConsumer(
                arena.allocator(),
                .{ .consumer_arn = consumer_arn },
                .{},
            ) catch {};
        }
        _ = shared_client.deleteStream(
            arena.allocator(),
            .{
                .stream_name = stream_name,
                .enforce_consumer_deletion = true,
            },
            .{},
        ) catch {};
    }
    shared_client.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "describeStreamSummary returns active status" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.describeStreamSummary(
        arena.allocator(),
        .{ .stream_name = stream_name },
        .{},
    );

    const summary = result.stream_description_summary orelse
        return error.MissingSummary;
    try std.testing.expectEqual(
        .active,
        summary.stream_status,
    );
}

test "listStreams includes created stream" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.listStreams(
        arena.allocator(),
        .{},
        .{},
    );

    const names = result.stream_names orelse
        return error.MissingStreamNames;
    var found = false;
    for (names) |name| {
        if (std.mem.eql(u8, name, stream_name)) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);
}

test "putRecord writes data" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.putRecord(
        arena.allocator(),
        .{
            .stream_name = stream_name,
            .data = "hello kinesis",
            .partition_key = "pk-1",
        },
        .{},
    );
    try std.testing.expect(result.shard_id.len > 0);
    try std.testing.expect(
        result.sequence_number.len > 0,
    );
}

test "getShardIterator and getRecords reads back data" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const shards = try shared_client.listShards(
        arena.allocator(),
        .{ .stream_name = stream_name },
        .{},
    );
    const shard_list = shards.shards orelse
        return error.NoShards;
    if (shard_list.len == 0) return error.NoShards;

    const iter_result = try shared_client.getShardIterator(
        arena.allocator(),
        .{
            .stream_name = stream_name,
            .shard_id = shard_list[0].shard_id,
            .shard_iterator_type = .trim_horizon,
        },
        .{},
    );
    const iterator = iter_result.shard_iterator orelse
        return error.MissingShardIterator;

    var attempts: u32 = 0;
    while (attempts < 10) : (attempts += 1) {
        const records = try shared_client.getRecords(
            arena.allocator(),
            .{ .shard_iterator = iterator },
            .{},
        );
        const record_list = records.records orelse {
            std.Thread.sleep(std.time.ns_per_s);
            continue;
        };
        if (record_list.len == 0) {
            std.Thread.sleep(std.time.ns_per_s);
            continue;
        }
        const decoded = try std.base64.standard.Decoder
            .decode(
            try arena.allocator().alloc(
                u8,
                try std.base64.standard.Decoder.calcSize(
                    record_list[0].data.len,
                ),
            ),
            record_list[0].data,
        );
        try std.testing.expectEqualStrings(
            "hello kinesis",
            decoded,
        );
        return;
    }
    return error.NoRecordsFound;
}

test "listShards returns shard info" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.listShards(
        arena.allocator(),
        .{ .stream_name = stream_name },
        .{},
    );

    const shards = result.shards orelse
        return error.MissingShards;
    try std.testing.expect(shards.len >= 1);
}

test "registerStreamConsumer creates consumer" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const reg = try shared_client.registerStreamConsumer(
        arena.allocator(),
        .{
            .stream_arn = stream_arn,
            .consumer_name = "sdk-zig-live-consumer",
        },
        .{},
    );
    const consumer = reg.consumer orelse
        return error.MissingConsumer;
    const c_arn = consumer.consumer_arn;
    const len = @min(c_arn.len, consumer_arn_buf.len);
    @memcpy(consumer_arn_buf[0..len], c_arn[0..len]);
    consumer_arn = consumer_arn_buf[0..len];
    try std.testing.expect(consumer_arn.len > 0);

    // Poll until consumer is queryable
    var attempts: u32 = 0;
    while (attempts < 30) : (attempts += 1) {
        const desc =
            shared_client.describeStreamConsumer(
                arena.allocator(),
                .{ .consumer_arn = consumer_arn },
                .{},
            ) catch {
                std.Thread.sleep(
                    2 * std.time.ns_per_s,
                );
                attempts += 1;
                continue;
            };
        if (desc.consumer_description) |cd| {
            try std.testing.expectEqualStrings(
                "sdk-zig-live-consumer",
                cd.consumer_name,
            );
            return;
        }
        std.Thread.sleep(2 * std.time.ns_per_s);
    }
    return error.ConsumerNotFound;
}
