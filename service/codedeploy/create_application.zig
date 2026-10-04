const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComputePlatform = @import("compute_platform.zig").ComputePlatform;
const Tag = @import("tag.zig").Tag;

pub const CreateApplicationInput = struct {
    /// The name of the application. This name must be unique with the applicable
    /// user or
    /// Amazon Web Services account.
    application_name: []const u8,

    /// The destination platform type for the deployment (`Lambda`,
    /// `Server`, or `ECS`).
    compute_platform: ?ComputePlatform = null,

    /// The metadata that you apply to CodeDeploy applications to help you organize
    /// and
    /// categorize them. Each tag consists of a key and an optional value, both of
    /// which you
    /// define.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .application_name = "applicationName",
        .compute_platform = "computePlatform",
        .tags = "tags",
    };
};

pub const CreateApplicationOutput = struct {
    /// A unique application ID.
    application_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationInput, options: CallOptions) !CreateApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codedeploy", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codedeploy", "CodeDeploy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.CreateApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApplicationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateApplicationOutput, body, allocator);
}
