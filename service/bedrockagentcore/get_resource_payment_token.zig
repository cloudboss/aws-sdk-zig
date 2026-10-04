const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PaymentTokenRequestInput = @import("payment_token_request_input.zig").PaymentTokenRequestInput;
const PaymentTokenResponseOutput = @import("payment_token_response_output.zig").PaymentTokenResponseOutput;

pub const GetResourcePaymentTokenInput = struct {
    /// Vendor-specific token request input
    /// Contains all request parameters in a type-safe, vendor-specific structure
    payment_token_request: PaymentTokenRequestInput,

    /// Name of the payment credential provider to use
    resource_credential_provider_name: []const u8,

    /// Workload access token for authorization. Named workloadIdentityToken for
    /// consistency with APIKey and OAuth2CredentialProvider.
    workload_identity_token: []const u8,

    pub const json_field_names = .{
        .payment_token_request = "paymentTokenRequest",
        .resource_credential_provider_name = "resourceCredentialProviderName",
        .workload_identity_token = "workloadIdentityToken",
    };
};

pub const GetResourcePaymentTokenOutput = struct {
    /// Vendor-specific token response output
    /// Contains all response data in a type-safe, vendor-specific structure
    payment_token_response: ?PaymentTokenResponseOutput = null,

    pub const json_field_names = .{
        .payment_token_response = "paymentTokenResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourcePaymentTokenInput, options: CallOptions) !GetResourcePaymentTokenOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourcePaymentTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/identities/payment/token";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"paymentTokenRequest\":");
    try aws.json.writeValue(@TypeOf(input.payment_token_request), input.payment_token_request, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceCredentialProviderName\":");
    try aws.json.writeValue(@TypeOf(input.resource_credential_provider_name), input.resource_credential_provider_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"workloadIdentityToken\":");
    try aws.json.writeValue(@TypeOf(input.workload_identity_token), input.workload_identity_token, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourcePaymentTokenOutput {
    var result: GetResourcePaymentTokenOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetResourcePaymentTokenOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
