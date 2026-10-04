const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegistryId = @import("registry_id.zig").RegistryId;
const RegistryStatus = @import("registry_status.zig").RegistryStatus;

pub const GetRegistryInput = struct {
    /// This is a wrapper structure that may contain the registry name and Amazon
    /// Resource Name (ARN).
    registry_id: RegistryId,

    pub const json_field_names = .{
        .registry_id = "RegistryId",
    };
};

pub const GetRegistryOutput = struct {
    /// The date and time the registry was created.
    created_time: ?[]const u8 = null,

    /// A description of the registry.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the registry.
    registry_arn: ?[]const u8 = null,

    /// The name of the registry.
    registry_name: ?[]const u8 = null,

    /// The status of the registry.
    status: ?RegistryStatus = null,

    /// The date and time the registry was updated.
    updated_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .description = "Description",
        .registry_arn = "RegistryArn",
        .registry_name = "RegistryName",
        .status = "Status",
        .updated_time = "UpdatedTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRegistryInput, options: CallOptions) !GetRegistryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRegistryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetRegistry");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRegistryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRegistryOutput, body, allocator);
}
