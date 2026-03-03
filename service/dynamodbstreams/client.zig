const aws = @import("aws");
const std = @import("std");

const describe_stream = @import("describe_stream.zig");
const get_records = @import("get_records.zig");
const get_shard_iterator = @import("get_shard_iterator.zig");
const list_streams = @import("list_streams.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "DynamoDB Streams";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Returns information about a stream, including the current status of the
    /// stream, its Amazon Resource Name (ARN), the composition of its shards, and
    /// its corresponding DynamoDB table.
    ///
    /// You can call `DescribeStream` at a maximum rate of 10 times per second.
    ///
    /// Each shard in the stream has a `SequenceNumberRange` associated with it. If
    /// the
    /// `SequenceNumberRange` has a `StartingSequenceNumber` but no
    /// `EndingSequenceNumber`, then the shard is still open (able to receive more
    /// stream
    /// records). If both `StartingSequenceNumber` and `EndingSequenceNumber`
    /// are present, then that shard is closed and can no longer receive more data.
    pub fn describeStream(self: *Self, allocator: std.mem.Allocator, input: describe_stream.DescribeStreamInput, options: describe_stream.Options) !describe_stream.DescribeStreamOutput {
        return describe_stream.execute(self, allocator, input, options);
    }

    /// Retrieves the stream records from a given shard.
    ///
    /// Specify a shard iterator using the `ShardIterator` parameter. The shard
    /// iterator
    /// specifies the position in the shard from which you want to start reading
    /// stream records
    /// sequentially. If there are no stream records available in the portion of the
    /// shard that the
    /// iterator points to, `GetRecords` returns an empty list. Note that it might
    /// take
    /// multiple calls to get to a portion of the shard that contains stream
    /// records.
    ///
    /// `GetRecords` can retrieve a maximum of 1 MB of data or 1000 stream records,
    /// whichever comes first.
    pub fn getRecords(self: *Self, allocator: std.mem.Allocator, input: get_records.GetRecordsInput, options: get_records.Options) !get_records.GetRecordsOutput {
        return get_records.execute(self, allocator, input, options);
    }

    /// Returns a shard iterator. A shard iterator provides information
    /// about how to retrieve the stream records from within a shard. Use
    /// the shard iterator in a subsequent
    /// `GetRecords` request to read the stream records
    /// from the shard.
    ///
    /// A shard iterator expires 15 minutes after it is returned to the requester.
    pub fn getShardIterator(self: *Self, allocator: std.mem.Allocator, input: get_shard_iterator.GetShardIteratorInput, options: get_shard_iterator.Options) !get_shard_iterator.GetShardIteratorOutput {
        return get_shard_iterator.execute(self, allocator, input, options);
    }

    /// Returns an array of stream ARNs associated with the current account and
    /// endpoint. If the
    /// `TableName` parameter is present, then `ListStreams` will return only the
    /// streams ARNs for that table.
    ///
    /// You can call `ListStreams` at a maximum rate of 5 times per second.
    pub fn listStreams(self: *Self, allocator: std.mem.Allocator, input: list_streams.ListStreamsInput, options: list_streams.Options) !list_streams.ListStreamsOutput {
        return list_streams.execute(self, allocator, input, options);
    }
};
