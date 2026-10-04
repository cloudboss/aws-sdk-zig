const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaggableResourceType = @import("taggable_resource_type.zig").TaggableResourceType;
const Tag = @import("tag.zig").Tag;

pub const DescribeTagsInput = struct {
    /// The ID of the ML object. For example, `exampleModelId`.
    resource_id: []const u8,

    /// The type of the ML object.
    resource_type: TaggableResourceType,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};

pub const DescribeTagsOutput = struct {
    /// The ID of the tagged ML object.
    resource_id: ?[]const u8 = null,

    /// The type of the tagged ML object.
    resource_type: ?TaggableResourceType = null,

    /// A list of tags associated with the ML object.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTagsInput, options: CallOptions) !DescribeTagsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "machinelearning", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTagsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("machinelearning", "Machine Learning", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonML_20141212.DescribeTags");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTagsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeTagsOutput, body, allocator);
}
