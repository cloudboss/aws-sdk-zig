const std = @import("std");
const aws = @import("aws");
const kinesis = @import("kinesis");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: kinesis.Client = undefined;
var shared_cfg: aws.Config = undefined;
var shared_init = false;

const stream_name = "sdk-zig-kinesis-test";
const consumer_name = "sdk-zig-consumer";
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

    // Create stream with 1 shard
    _ = try kinesis.create_stream.execute(
        &shared_client,
        arena.allocator(),
        .{
            .stream_name = stream_name,
            .shard_count = 1,
        },
        .{},
    );

    // Wait for stream to become ACTIVE
    var attempts: u32 = 0;
    while (attempts < 30) : (attempts += 1) {
        const desc = try kinesis.describe_stream_summary.execute(
            &shared_client,
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
        std.Thread.sleep(500 * std.time.ns_per_ms);
    }
    if (stream_arn.len == 0) return error.StreamNotActive;

    // Register enhanced fan-out consumer
    const reg = try kinesis.register_stream_consumer.execute(
        &shared_client,
        arena.allocator(),
        .{
            .stream_arn = stream_arn,
            .consumer_name = consumer_name,
        },
        .{},
    );
    if (reg.consumer) |c| {
        const len = @min(
            c.consumer_arn.len,
            consumer_arn_buf.len,
        );
        @memcpy(consumer_arn_buf[0..len], c.consumer_arn[0..len]);
        consumer_arn = consumer_arn_buf[0..len];
    }

    // Wait for consumer to become ACTIVE
    attempts = 0;
    while (attempts < 30) : (attempts += 1) {
        const desc = try kinesis.describe_stream_consumer.execute(
            &shared_client,
            arena.allocator(),
            .{ .consumer_arn = consumer_arn },
            .{},
        );
        if (desc.consumer_description) |cd| {
            if (cd.consumer_status == .active) break;
        }
        std.Thread.sleep(500 * std.time.ns_per_ms);
    }

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
            _ = kinesis.deregister_stream_consumer.execute(
                &shared_client,
                arena.allocator(),
                .{ .consumer_arn = consumer_arn },
                .{},
            ) catch {};
        }
        _ = kinesis.delete_stream.execute(
            &shared_client,
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

test "PutRecord writes data to stream" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try kinesis.put_record.execute(
        &shared_client,
        arena.allocator(),
        .{
            .stream_name = stream_name,
            .data = "hello kinesis",
            .partition_key = "test-key",
        },
        .{},
    );
    try std.testing.expect(result.shard_id.len > 0);
    try std.testing.expect(result.sequence_number.len > 0);
}

test "SubscribeToShard returns event stream reader" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    const allocator = gpa.allocator();

    // Get the shard ID
    const shards = try kinesis.list_shards.execute(
        &shared_client,
        arena.allocator(),
        .{ .stream_name = stream_name },
        .{},
    );
    const shard_list = shards.shards orelse
        return error.NoShards;
    if (shard_list.len == 0) return error.NoShards;
    const shard_id = shard_list[0].shard_id;

    // Subscribe to shard from the beginning
    var result = try kinesis.subscribe_to_shard.execute(
        &shared_client,
        allocator,
        .{
            .consumer_arn = consumer_arn,
            .shard_id = shard_id,
            .starting_position = .{
                .type = .trim_horizon,
                .sequence_number = null,
                .timestamp = null,
            },
        },
        .{},
    );
    defer result.event_stream.deinit();

    // Read at least one event from the stream
    var got_event = false;
    var read_attempts: u32 = 0;
    while (read_attempts < 10) : (read_attempts += 1) {
        const event = result.event_stream.next() catch break;
        if (event) |ev| {
            try std.testing.expect(ev.event_type.len > 0);
            got_event = true;
            break;
        } else {
            break;
        }
    }
    try std.testing.expect(got_event);
}
