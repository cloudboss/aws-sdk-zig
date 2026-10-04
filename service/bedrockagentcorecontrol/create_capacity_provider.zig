const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComputeConfiguration = @import("compute_configuration.zig").ComputeConfiguration;
const PermissionsConfiguration = @import("permissions_configuration.zig").PermissionsConfiguration;
const CapacityProviderStatus = @import("capacity_provider_status.zig").CapacityProviderStatus;

pub const CreateCapacityProviderInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The compute configuration for the capacity provider. This defines the Amazon
    /// EC2 compute resources used to launch instances: the operating system,
    /// allowed instance types, networking, and storage.
    compute_configuration: ComputeConfiguration,

    /// An optional description of the capacity provider. If you don't specify a
    /// description, the service creates the capacity provider without one.
    description: ?[]const u8 = null,

    /// The name of the capacity provider. The name must be unique within your
    /// account.
    name: []const u8,

    /// The permissions configuration for the capacity provider. This specifies the
    /// IAM role that AgentCore uses to manage the Amazon EC2 instances on your
    /// behalf.
    permissions_configuration: PermissionsConfiguration,

    /// A map of tag keys and values to associate with the capacity provider. If you
    /// don't specify tags, the capacity provider is created with no tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .compute_configuration = "computeConfiguration",
        .description = "description",
        .name = "name",
        .permissions_configuration = "permissionsConfiguration",
        .tags = "tags",
    };
};

pub const CreateCapacityProviderOutput = struct {
    /// The Amazon Resource Name (ARN) of the capacity provider.
    capacity_provider_arn: []const u8,

    /// The unique identifier of the created capacity provider.
    capacity_provider_id: []const u8,

    /// The name of the capacity provider.
    name: []const u8,

    /// The current status of the capacity provider. For possible values, see
    /// `CapacityProviderStatus`.
    status: CapacityProviderStatus,

    pub const json_field_names = .{
        .capacity_provider_arn = "capacityProviderArn",
        .capacity_provider_id = "capacityProviderId",
        .name = "name",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCapacityProviderInput, options: CallOptions) !CreateCapacityProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCapacityProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/capacity-providers";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"computeConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.compute_configuration), input.compute_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"permissionsConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.permissions_configuration), input.permissions_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCapacityProviderOutput {
    const result: CreateCapacityProviderOutput = try aws.json.parseJsonObject(
        CreateCapacityProviderOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
