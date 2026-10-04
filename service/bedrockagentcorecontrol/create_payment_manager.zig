const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const PaymentsAuthorizerType = @import("payments_authorizer_type.zig").PaymentsAuthorizerType;
const PaymentManagerStatus = @import("payment_manager_status.zig").PaymentManagerStatus;
const WorkloadIdentityDetails = @import("workload_identity_details.zig").WorkloadIdentityDetails;

pub const CreatePaymentManagerInput = struct {
    /// The authorizer configuration for the payment manager.
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The type of authorizer to use for the payment manager.
    ///
    /// * `CUSTOM_JWT` - Authorize with a bearer token.
    /// * `AWS_IAM` - Authorize with your Amazon Web Services IAM credentials.
    authorizer_type: PaymentsAuthorizerType,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// A description of the payment manager.
    description: ?[]const u8 = null,

    /// The name of the payment manager.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that the payment manager
    /// assumes to access resources on your behalf.
    role_arn: []const u8,

    /// A map of tag keys and values to assign to the payment manager.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .authorizer_configuration = "authorizerConfiguration",
        .authorizer_type = "authorizerType",
        .client_token = "clientToken",
        .description = "description",
        .name = "name",
        .role_arn = "roleArn",
        .tags = "tags",
    };
};

pub const CreatePaymentManagerOutput = struct {
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The type of authorizer for the created payment manager.
    authorizer_type: PaymentsAuthorizerType,

    /// The timestamp when the payment manager was created.
    created_at: i64,

    /// The name of the created payment manager.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the created payment manager.
    payment_manager_arn: []const u8,

    /// The unique identifier of the created payment manager.
    payment_manager_id: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the created
    /// payment manager.
    role_arn: []const u8,

    /// The current status of the payment manager. Possible values include
    /// `CREATING`, `READY`, `UPDATING`, `DELETING`, `CREATE_FAILED`,
    /// `UPDATE_FAILED`, and `DELETE_FAILED`.
    status: PaymentManagerStatus,

    /// The tags associated with the created payment manager.
    tags: ?[]const aws.map.StringMapEntry = null,

    workload_identity_details: ?WorkloadIdentityDetails = null,

    pub const json_field_names = .{
        .authorizer_configuration = "authorizerConfiguration",
        .authorizer_type = "authorizerType",
        .created_at = "createdAt",
        .name = "name",
        .payment_manager_arn = "paymentManagerArn",
        .payment_manager_id = "paymentManagerId",
        .role_arn = "roleArn",
        .status = "status",
        .tags = "tags",
        .workload_identity_details = "workloadIdentityDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePaymentManagerInput, options: CallOptions) !CreatePaymentManagerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePaymentManagerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/payments/managers";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.authorizer_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authorizerConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"authorizerType\":");
    try aws.json.writeValue(@TypeOf(input.authorizer_type), input.authorizer_type, allocator, &body_buf);
    has_prev = true;
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
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
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePaymentManagerOutput {
    var result: CreatePaymentManagerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePaymentManagerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
