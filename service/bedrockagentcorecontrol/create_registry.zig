const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApprovalConfiguration = @import("approval_configuration.zig").ApprovalConfiguration;
const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const RegistryAuthorizerType = @import("registry_authorizer_type.zig").RegistryAuthorizerType;

pub const CreateRegistryInput = struct {
    /// The approval configuration for registry records. Controls whether records
    /// require explicit approval before becoming active. See the
    /// `ApprovalConfiguration` data type for supported configuration options.
    approval_configuration: ?ApprovalConfiguration = null,

    /// The authorizer configuration for the registry. Required if `authorizerType`
    /// is `CUSTOM_JWT`. For details, see the `AuthorizerConfiguration` data type.
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The type of authorizer to use for the registry. This controls the
    /// authorization method for the Search and Invoke APIs used by consumers, and
    /// does not affect the standard CRUDL APIs for registry and registry record
    /// management used by administrators.
    ///
    /// * `CUSTOM_JWT` - Authorize with a bearer token.
    /// * `AWS_IAM` - Authorize with your Amazon Web Services IAM credentials.
    authorizer_type: ?RegistryAuthorizerType = null,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// A description of the registry.
    description: ?[]const u8 = null,

    /// The name of the registry. The name must be unique within your account and
    /// can contain alphanumeric characters and underscores.
    name: []const u8,

    pub const json_field_names = .{
        .approval_configuration = "approvalConfiguration",
        .authorizer_configuration = "authorizerConfiguration",
        .authorizer_type = "authorizerType",
        .client_token = "clientToken",
        .description = "description",
        .name = "name",
    };
};

pub const CreateRegistryOutput = struct {
    /// The Amazon Resource Name (ARN) of the created registry.
    registry_arn: []const u8,

    pub const json_field_names = .{
        .registry_arn = "registryArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRegistryInput, options: CallOptions) !CreateRegistryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRegistryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/registries";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.approval_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"approvalConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.authorizer_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authorizerConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.authorizer_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authorizerType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRegistryOutput {
    const result: CreateRegistryOutput = try aws.json.parseJsonObject(
        CreateRegistryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
