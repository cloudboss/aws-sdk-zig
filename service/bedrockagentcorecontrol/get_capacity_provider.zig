const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComputeConfiguration = @import("compute_configuration.zig").ComputeConfiguration;
const PermissionsConfiguration = @import("permissions_configuration.zig").PermissionsConfiguration;
const CapacityProviderStatus = @import("capacity_provider_status.zig").CapacityProviderStatus;
const CapacityProviderStatusCode = @import("capacity_provider_status_code.zig").CapacityProviderStatusCode;

pub const GetCapacityProviderInput = struct {
    /// The unique identifier of the capacity provider.
    capacity_provider_id: []const u8,

    pub const json_field_names = .{
        .capacity_provider_id = "capacityProviderId",
    };
};

pub const GetCapacityProviderOutput = struct {
    /// The Amazon Resource Name (ARN) of the capacity provider.
    capacity_provider_arn: []const u8,

    /// The unique identifier of the capacity provider.
    capacity_provider_id: []const u8,

    /// The compute configuration for the capacity provider.
    compute_configuration: ?ComputeConfiguration = null,

    /// The timestamp when the capacity provider was created.
    created_at: i64,

    /// The description of the capacity provider, if one was provided.
    description: ?[]const u8 = null,

    /// The timestamp when the capacity provider was last updated.
    last_updated_at: i64,

    /// The name of the capacity provider.
    name: []const u8,

    /// The permissions configuration for the capacity provider.
    permissions_configuration: ?PermissionsConfiguration = null,

    /// The current status of the capacity provider. For possible values, see
    /// `CapacityProviderStatus`.
    status: CapacityProviderStatus,

    /// A reason code for a capacity provider that is not in the `READY` state. Use
    /// this code for programmatic error handling.
    status_code: ?CapacityProviderStatusCode = null,

    /// A human-readable message that describes why the capacity provider is not in
    /// the `READY` state. Because these messages can change, use `statusCode` for
    /// programmatic error handling.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_provider_arn = "capacityProviderArn",
        .capacity_provider_id = "capacityProviderId",
        .compute_configuration = "computeConfiguration",
        .created_at = "createdAt",
        .description = "description",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .permissions_configuration = "permissionsConfiguration",
        .status = "status",
        .status_code = "statusCode",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCapacityProviderInput, options: CallOptions) !GetCapacityProviderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCapacityProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/capacity-providers/");
    try path_buf.appendSlice(allocator, input.capacity_provider_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCapacityProviderOutput {
    const result: GetCapacityProviderOutput = try aws.json.parseJsonObject(
        GetCapacityProviderOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
