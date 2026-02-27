const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const StartingPosition = @import("starting_position.zig").StartingPosition;
const SubscribeToShardEventStream = @import("subscribe_to_shard_event_stream.zig").SubscribeToShardEventStream;

pub const SubscribeToShardInput = struct {
    /// For this parameter, use the value you obtained when you called
    /// RegisterStreamConsumer.
    consumer_arn: []const u8,

    /// The ID of the shard you want to subscribe to. To see a list of all the
    /// shards for a
    /// given stream, use ListShards.
    shard_id: []const u8,

    /// The starting position in the data stream from which to start streaming.
    starting_position: StartingPosition,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .consumer_arn = "ConsumerARN",
        .shard_id = "ShardId",
        .starting_position = "StartingPosition",
        .stream_id = "StreamId",
    };
};

pub const SubscribeToShardOutput = struct {
    /// The event stream that your consumer can use to read records from the shard.
    event_stream: ?SubscribeToShardEventStream = null,

    pub const json_field_names = .{
        .event_stream = "EventStream",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SubscribeToShardInput, options: Options) !SubscribeToShardOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}
