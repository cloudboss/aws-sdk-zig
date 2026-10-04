const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdatedDescription = @import("updated_description.zig").UpdatedDescription;
const CapacityProviderStatus = @import("capacity_provider_status.zig").CapacityProviderStatus;

pub const UpdateCapacityProviderInput = struct {
    /// The unique identifier of the capacity provider to update.
    capacity_provider_id: []const u8,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The updated description of the capacity provider.
    description: ?UpdatedDescription = null,

    pub const json_field_names = .{
        .capacity_provider_id = "capacityProviderId",
        .client_token = "clientToken",
        .description = "description",
    };
};

pub const UpdateCapacityProviderOutput = struct {
    /// The Amazon Resource Name (ARN) of the capacity provider.
    capacity_provider_arn: []const u8,

    /// The unique identifier of the capacity provider.
    capacity_provider_id: []const u8,

    /// The timestamp when the capacity provider was created.
    created_at: i64,

    /// The timestamp when the capacity provider was last updated.
    last_updated_at: i64,

    /// The name of the capacity provider.
    name: []const u8,

    /// The current status of the capacity provider. For possible values, see
    /// `CapacityProviderStatus`.
    status: CapacityProviderStatus,

    pub const json_field_names = .{
        .capacity_provider_arn = "capacityProviderArn",
        .capacity_provider_id = "capacityProviderId",
        .created_at = "createdAt",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCapacityProviderInput, options: CallOptions) !UpdateCapacityProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCapacityProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/capacity-providers/");
    try path_buf.appendSlice(allocator, input.capacity_provider_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCapacityProviderOutput {
    const result: UpdateCapacityProviderOutput = try aws.json.parseJsonObject(
        UpdateCapacityProviderOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
