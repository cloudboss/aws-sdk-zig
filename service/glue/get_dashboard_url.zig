const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlueResourceType = @import("glue_resource_type.zig").GlueResourceType;

pub const GetDashboardUrlInput = struct {
    /// The origin of the request.
    request_origin: ?[]const u8 = null,

    /// The unique identifier of the resource for which to retrieve the dashboard
    /// URL.
    resource_id: []const u8,

    /// The type of the resource. Valid values are `SESSION` and `JOB`.
    resource_type: GlueResourceType,

    pub const json_field_names = .{
        .request_origin = "RequestOrigin",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};

pub const GetDashboardUrlOutput = struct {
    /// The URL for the Spark monitoring dashboard.
    url: []const u8,

    pub const json_field_names = .{
        .url = "Url",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDashboardUrlInput, options: CallOptions) !GetDashboardUrlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDashboardUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetDashboardUrl");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDashboardUrlOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetDashboardUrlOutput, body, allocator);
}
