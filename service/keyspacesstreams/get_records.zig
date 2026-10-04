const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Record = @import("record.zig").Record;
const IteratorDescription = @import("iterator_description.zig").IteratorDescription;

pub const GetRecordsInput = struct {
    /// The maximum number of records to return in a single `GetRecords` request.
    /// The default value is 100. You can specify a limit between 1 and 1000, but
    /// the actual number returned might be less than the specified maximum if the
    /// size of the data for the returned records exceeds the internal size limit.
    max_results: ?i32 = null,

    /// The unique identifier of the shard iterator. A shard iterator specifies the
    /// position in the shard from which you want to start reading data records
    /// sequentially. You obtain this value by calling the `GetShardIterator `
    /// operation. Each shard iterator is valid for 15 minutes after creation.
    shard_iterator: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .shard_iterator = "shardIterator",
    };
};

pub const GetRecordsOutput = struct {
    /// An array of change data records retrieved from the specified shard. Each
    /// record represents a single data modification (insert, update, or delete) to
    /// a row in the Amazon Keyspaces table. Records include the primary key columns
    /// and information about what data was modified.
    change_records: ?[]const Record = null,

    /// Provides information about the current iterator at the time GetRecords
    /// request was processed by Keyspaces.
    iterator_description: ?IteratorDescription = null,

    /// The next position in the shard from which to start sequentially reading data
    /// records. If null, the shard has been closed and the requested iterator will
    /// not return any more data.
    next_shard_iterator: ?[]const u8 = null,

    pub const json_field_names = .{
        .change_records = "changeRecords",
        .iterator_description = "iteratorDescription",
        .next_shard_iterator = "nextShardIterator",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecordsInput, options: CallOptions) !GetRecordsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cassandra", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecordsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cassandra-streams", "KeyspacesStreams", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "KeyspacesStreams.GetRecords");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRecordsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRecordsOutput, body, allocator);
}
