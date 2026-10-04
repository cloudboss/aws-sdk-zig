const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const ListTagsForStreamInput = struct {
    /// The key to use as the starting point for the list of tags. If this parameter
    /// is set,
    /// `ListTagsForStream` gets all tags that occur after
    /// `ExclusiveStartTagKey`.
    exclusive_start_tag_key: ?[]const u8 = null,

    /// The number of tags to return. If this number is less than the total number
    /// of tags
    /// associated with the stream, `HasMoreTags` is set to `true`. To
    /// list additional tags, set `ExclusiveStartTagKey` to the last key in the
    /// response.
    limit: ?i32 = null,

    /// The ARN of the stream.
    stream_arn: ?[]const u8 = null,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    /// The name of the stream.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .exclusive_start_tag_key = "ExclusiveStartTagKey",
        .limit = "Limit",
        .stream_arn = "StreamARN",
        .stream_id = "StreamId",
        .stream_name = "StreamName",
    };
};

pub const ListTagsForStreamOutput = struct {
    /// If set to `true`, more tags are available. To request additional tags, set
    /// `ExclusiveStartTagKey` to the key of the last tag returned.
    has_more_tags: bool,

    /// A list of tags associated with `StreamName`, starting with the first tag
    /// after `ExclusiveStartTagKey` and up to the specified `Limit`.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .has_more_tags = "HasMoreTags",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTagsForStreamInput, options: CallOptions) !ListTagsForStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesis", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTagsForStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesis", "Kinesis", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.ListTagsForStream");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTagsForStreamOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListTagsForStreamOutput, body, allocator);
}
