const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const ListTagsForDeliveryStreamInput = struct {
    /// The name of the Firehose stream whose tags you want to list.
    delivery_stream_name: []const u8,

    /// The key to use as the starting point for the list of tags. If you set this
    /// parameter,
    /// `ListTagsForDeliveryStream` gets all tags that occur after
    /// `ExclusiveStartTagKey`.
    exclusive_start_tag_key: ?[]const u8 = null,

    /// The number of tags to return. If this number is less than the total number
    /// of tags
    /// associated with the Firehose stream, `HasMoreTags` is set to `true`
    /// in the response. To list additional tags, set `ExclusiveStartTagKey` to the
    /// last
    /// key in the response.
    limit: ?i32 = null,

    pub const json_field_names = .{
        .delivery_stream_name = "DeliveryStreamName",
        .exclusive_start_tag_key = "ExclusiveStartTagKey",
        .limit = "Limit",
    };
};

pub const ListTagsForDeliveryStreamOutput = struct {
    /// If this is `true` in the response, more tags are available. To list the
    /// remaining tags, set `ExclusiveStartTagKey` to the key of the last tag
    /// returned
    /// and call `ListTagsForDeliveryStream` again.
    has_more_tags: bool,

    /// A list of tags associated with `DeliveryStreamName`, starting with the
    /// first tag after `ExclusiveStartTagKey` and up to the specified
    /// `Limit`.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .has_more_tags = "HasMoreTags",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTagsForDeliveryStreamInput, options: CallOptions) !ListTagsForDeliveryStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "firehose", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTagsForDeliveryStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("firehose", "Firehose", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Firehose_20150804.ListTagsForDeliveryStream");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTagsForDeliveryStreamOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListTagsForDeliveryStreamOutput, body, allocator);
}
