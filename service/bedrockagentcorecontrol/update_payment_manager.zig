const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const PaymentsAuthorizerType = @import("payments_authorizer_type.zig").PaymentsAuthorizerType;
const PaymentManagerStatus = @import("payment_manager_status.zig").PaymentManagerStatus;
const WorkloadIdentityDetails = @import("workload_identity_details.zig").WorkloadIdentityDetails;

pub const UpdatePaymentManagerInput = struct {
    /// The updated authorizer configuration for the payment manager.
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The updated authorizer type for the payment manager.
    authorizer_type: ?PaymentsAuthorizerType = null,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The updated description of the payment manager.
    description: ?[]const u8 = null,

    /// The updated Amazon Resource Name (ARN) of the customer managed KMS key used
    /// to encrypt sensitive payment manager data at rest.
    kms_key_arn: ?[]const u8 = null,

    /// The unique identifier of the payment manager to update.
    payment_manager_id: []const u8,

    /// The updated Amazon Resource Name (ARN) of the IAM role for the payment
    /// manager.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorizer_configuration = "authorizerConfiguration",
        .authorizer_type = "authorizerType",
        .client_token = "clientToken",
        .description = "description",
        .kms_key_arn = "kmsKeyArn",
        .payment_manager_id = "paymentManagerId",
        .role_arn = "roleArn",
    };
};

pub const UpdatePaymentManagerOutput = struct {
    /// The type of authorizer for the updated payment manager.
    authorizer_type: PaymentsAuthorizerType,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt sensitive
    /// payment manager data at rest, if configured.
    kms_key_arn: ?[]const u8 = null,

    /// The timestamp when the payment manager was last updated.
    last_updated_at: i64,

    /// The name of the updated payment manager.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the updated payment manager.
    payment_manager_arn: []const u8,

    /// The unique identifier of the updated payment manager.
    payment_manager_id: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the updated
    /// payment manager.
    role_arn: []const u8,

    /// The current status of the updated payment manager. Possible values include
    /// `CREATING`, `READY`, `UPDATING`, `DELETING`, `CREATE_FAILED`,
    /// `UPDATE_FAILED`, and `DELETE_FAILED`.
    status: PaymentManagerStatus,

    workload_identity_details: ?WorkloadIdentityDetails = null,

    pub const json_field_names = .{
        .authorizer_type = "authorizerType",
        .kms_key_arn = "kmsKeyArn",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .payment_manager_arn = "paymentManagerArn",
        .payment_manager_id = "paymentManagerId",
        .role_arn = "roleArn",
        .status = "status",
        .workload_identity_details = "workloadIdentityDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePaymentManagerInput, options: CallOptions) !UpdatePaymentManagerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePaymentManagerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/payments/managers/");
    try path_buf.appendSlice(allocator, input.payment_manager_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePaymentManagerOutput {
    const result: UpdatePaymentManagerOutput = try aws.json.parseJsonObject(
        UpdatePaymentManagerOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
