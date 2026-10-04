const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceSet = @import("resource_set.zig").ResourceSet;
const Tag = @import("tag.zig").Tag;

pub const PutResourceSetInput = struct {
    /// Details about the resource set to be created or updated.>
    resource_set: ResourceSet,

    /// Retrieves the tags associated with the specified resource set. Tags are
    /// key:value pairs that
    /// you can use to categorize and manage your resources, for purposes like
    /// billing. For
    /// example, you might set the tag key to "customer" and the value to the
    /// customer name or ID.
    /// You can specify one or more tags to add to each Amazon Web Services
    /// resource, up to 50 tags for a
    /// resource.
    tag_list: ?[]const Tag = null,

    pub const json_field_names = .{
        .resource_set = "ResourceSet",
        .tag_list = "TagList",
    };
};

pub const PutResourceSetOutput = struct {
    /// Details about the resource set.
    resource_set: ?ResourceSet = null,

    /// The Amazon Resource Name (ARN) of the resource set.
    resource_set_arn: []const u8,

    pub const json_field_names = .{
        .resource_set = "ResourceSet",
        .resource_set_arn = "ResourceSetArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourceSetInput, options: CallOptions) !PutResourceSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutResourceSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fms", "FMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.PutResourceSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResourceSetOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(PutResourceSetOutput, body, allocator);
}
