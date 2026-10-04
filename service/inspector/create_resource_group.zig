const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceGroupTag = @import("resource_group_tag.zig").ResourceGroupTag;

pub const CreateResourceGroupInput = struct {
    /// A collection of keys and an array of possible values,
    /// '[{"key":"key1","values":["Value1","Value2"]},{"key":"Key2","values":["Value3"]}]'.
    ///
    /// For example,'[{"key":"Name","values":["TestEC2Instance"]}]'.
    resource_group_tags: []const ResourceGroupTag,

    pub const json_field_names = .{
        .resource_group_tags = "resourceGroupTags",
    };
};

pub const CreateResourceGroupOutput = struct {
    /// The ARN that specifies the resource group that is created.
    resource_group_arn: []const u8,

    pub const json_field_names = .{
        .resource_group_arn = "resourceGroupArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResourceGroupInput, options: CallOptions) !CreateResourceGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResourceGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector", "Inspector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "InspectorService.CreateResourceGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResourceGroupOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateResourceGroupOutput, body, allocator);
}
