const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Attribute = @import("attribute.zig").Attribute;

pub const DeleteAttributesInput = struct {
    /// The attributes to delete from your resource. You can specify up to 10
    /// attributes for each request. For custom attributes, specify the attribute
    /// name and target ID, but don't specify the value. If you specify the target
    /// ID using the short form, you must also specify the target type.
    attributes: []const Attribute,

    /// The short name or full Amazon Resource Name (ARN) of the cluster that
    /// contains the resource to delete attributes. If you do not specify a cluster,
    /// the default cluster is assumed.
    cluster: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .cluster = "cluster",
    };
};

pub const DeleteAttributesOutput = struct {
    /// A list of attribute objects that were successfully deleted from your
    /// resource.
    attributes: ?[]const Attribute = null,

    pub const json_field_names = .{
        .attributes = "attributes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAttributesInput, options: CallOptions) !DeleteAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAttributesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.DeleteAttributes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAttributesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteAttributesOutput, body, allocator);
}
