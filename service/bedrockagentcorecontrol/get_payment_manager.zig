const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const PaymentsAuthorizerType = @import("payments_authorizer_type.zig").PaymentsAuthorizerType;
const PaymentManagerStatus = @import("payment_manager_status.zig").PaymentManagerStatus;
const WorkloadIdentityDetails = @import("workload_identity_details.zig").WorkloadIdentityDetails;

pub const GetPaymentManagerInput = struct {
    /// The unique identifier of the payment manager to retrieve.
    payment_manager_id: []const u8,

    pub const json_field_names = .{
        .payment_manager_id = "paymentManagerId",
    };
};

pub const GetPaymentManagerOutput = struct {
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The type of authorizer used by the payment manager.
    ///
    /// * `CUSTOM_JWT` - Authorize with a bearer token.
    /// * `AWS_IAM` - Authorize with your Amazon Web Services IAM credentials.
    authorizer_type: PaymentsAuthorizerType,

    /// The timestamp when the payment manager was created.
    created_at: i64,

    /// The description of the payment manager.
    description: ?[]const u8 = null,

    /// The timestamp when the payment manager was last updated.
    last_updated_at: i64,

    /// The name of the payment manager.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the payment manager.
    payment_manager_arn: []const u8,

    /// The unique identifier of the payment manager.
    payment_manager_id: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the payment
    /// manager.
    role_arn: []const u8,

    /// The current status of the payment manager. Possible values include
    /// `CREATING`, `READY`, `UPDATING`, `DELETING`, `CREATE_FAILED`,
    /// `UPDATE_FAILED`, and `DELETE_FAILED`.
    status: PaymentManagerStatus,

    /// The tags associated with the payment manager.
    tags: ?[]const aws.map.StringMapEntry = null,

    workload_identity_details: ?WorkloadIdentityDetails = null,

    pub const json_field_names = .{
        .authorizer_configuration = "authorizerConfiguration",
        .authorizer_type = "authorizerType",
        .created_at = "createdAt",
        .description = "description",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .payment_manager_arn = "paymentManagerArn",
        .payment_manager_id = "paymentManagerId",
        .role_arn = "roleArn",
        .status = "status",
        .tags = "tags",
        .workload_identity_details = "workloadIdentityDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPaymentManagerInput, options: CallOptions) !GetPaymentManagerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPaymentManagerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/payments/managers/");
    try path_buf.appendSlice(allocator, input.payment_manager_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPaymentManagerOutput {
    var result: GetPaymentManagerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPaymentManagerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
