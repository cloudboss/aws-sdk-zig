const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PushConfig = @import("push_config.zig").PushConfig;

pub const GetOtaTaskConfigurationInput = struct {
    /// The over-the-air (OTA) task configuration id.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const GetOtaTaskConfigurationOutput = struct {
    /// The timestamp value of when the over-the-air (OTA) task configuration was
    /// created at.
    created_at: ?i64 = null,

    /// A description of the over-the-air (OTA) task configuration.
    description: ?[]const u8 = null,

    /// The name of the over-the-air (OTA) task configuration.
    name: ?[]const u8 = null,

    /// Describes the type of configuration used for the over-the-air (OTA) task.
    push_config: ?PushConfig = null,

    /// The over-the-air (OTA) task configuration id.
    task_configuration_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .name = "Name",
        .push_config = "PushConfig",
        .task_configuration_id = "TaskConfigurationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOtaTaskConfigurationInput, options: CallOptions) !GetOtaTaskConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOtaTaskConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/ota-task-configurations/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOtaTaskConfigurationOutput {
    const result: GetOtaTaskConfigurationOutput = try aws.json.parseJsonObject(
        GetOtaTaskConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
