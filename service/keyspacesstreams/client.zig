const aws = @import("aws");
const std = @import("std");

const get_records = @import("get_records.zig");
const get_shard_iterator = @import("get_shard_iterator.zig");
const get_stream = @import("get_stream.zig");
const list_streams = @import("list_streams.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "KeyspacesStreams";

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

    /// Retrieves data records from a specified shard in an Amazon Keyspaces data
    /// stream. This operation returns a collection of data records from the shard,
    /// including the primary key columns and information about modifications made
    /// to the captured table data. Each record represents a single data
    /// modification in the Amazon Keyspaces table and includes metadata about when
    /// the change occurred.
    pub fn getRecords(self: *Self, allocator: std.mem.Allocator, input: get_records.GetRecordsInput, options: get_records.Options) !get_records.GetRecordsOutput {
        return get_records.execute(self, allocator, input, options);
    }

    /// Returns a shard iterator that serves as a bookmark for reading data from a
    /// specific position in an Amazon Keyspaces data stream's shard. The shard
    /// iterator specifies the shard position from which to start reading data
    /// records sequentially. You can specify whether to begin reading at the latest
    /// record, the oldest record, or at a particular sequence number within the
    /// shard.
    pub fn getShardIterator(self: *Self, allocator: std.mem.Allocator, input: get_shard_iterator.GetShardIteratorInput, options: get_shard_iterator.Options) !get_shard_iterator.GetShardIteratorOutput {
        return get_shard_iterator.execute(self, allocator, input, options);
    }

    /// Returns detailed information about a specific data capture stream for an
    /// Amazon Keyspaces table. The information includes the stream's Amazon
    /// Resource Name (ARN), creation time, current status, retention period, shard
    /// composition, and associated table details. This operation helps you monitor
    /// and manage the configuration of your Amazon Keyspaces data streams.
    pub fn getStream(self: *Self, allocator: std.mem.Allocator, input: get_stream.GetStreamInput, options: get_stream.Options) !get_stream.GetStreamOutput {
        return get_stream.execute(self, allocator, input, options);
    }

    /// Returns a list of all data capture streams associated with your Amazon
    /// Keyspaces account or for a specific keyspace or table. The response includes
    /// information such as stream ARNs, table associations, creation timestamps,
    /// and current status. This operation helps you discover and manage all active
    /// data streams in your Amazon Keyspaces environment.
    pub fn listStreams(self: *Self, allocator: std.mem.Allocator, input: list_streams.ListStreamsInput, options: list_streams.Options) !list_streams.ListStreamsOutput {
        return list_streams.execute(self, allocator, input, options);
    }

    pub fn getStreamPaginator(self: *Self, params: get_stream.GetStreamInput) paginator.GetStreamPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStreamsPaginator(self: *Self, params: list_streams.ListStreamsInput) paginator.ListStreamsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
