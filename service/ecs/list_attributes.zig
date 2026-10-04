const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TargetType = @import("target_type.zig").TargetType;
const Attribute = @import("attribute.zig").Attribute;

pub const ListAttributesInput = struct {
    /// The name of the attribute to filter the results with.
    attribute_name: ?[]const u8 = null,

    /// The value of the attribute to filter results with. You must also specify an
    /// attribute name to use this parameter.
    attribute_value: ?[]const u8 = null,

    /// The short name or full Amazon Resource Name (ARN) of the cluster to list
    /// attributes. If you do not specify a cluster, the default cluster is assumed.
    cluster: ?[]const u8 = null,

    /// The maximum number of cluster results that `ListAttributes` returned in
    /// paginated output. When this parameter is used, `ListAttributes` only returns
    /// `maxResults` results in a single page along with a `nextToken` response
    /// element. The remaining results of the initial request can be seen by sending
    /// another `ListAttributes` request with the returned `nextToken` value. This
    /// value can be between 1 and 100. If this parameter isn't used, then
    /// `ListAttributes` returns up to 100 results and a `nextToken` value if
    /// applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a `ListAttributes` request indicating
    /// that more results are available to fulfill the request and further calls are
    /// needed. If `maxResults` was provided, it's possible the number of results to
    /// be fewer than `maxResults`.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    /// The type of the target to list attributes with.
    target_type: TargetType,

    pub const json_field_names = .{
        .attribute_name = "attributeName",
        .attribute_value = "attributeValue",
        .cluster = "cluster",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .target_type = "targetType",
    };
};

pub const ListAttributesOutput = struct {
    /// A list of attribute objects that meet the criteria of the request.
    attributes: ?[]const Attribute = null,

    /// The `nextToken` value to include in a future `ListAttributes` request. When
    /// the results of a `ListAttributes` request exceed `maxResults`, this value
    /// can be used to retrieve the next page of results. This value is `null` when
    /// there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAttributesInput, options: CallOptions) !ListAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.ListAttributes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAttributesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAttributesOutput, body, allocator);
}
