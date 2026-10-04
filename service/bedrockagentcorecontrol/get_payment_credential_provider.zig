const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PaymentCredentialProviderVendorType = @import("payment_credential_provider_vendor_type.zig").PaymentCredentialProviderVendorType;
const PaymentProviderConfigurationOutput = @import("payment_provider_configuration_output.zig").PaymentProviderConfigurationOutput;

pub const GetPaymentCredentialProviderInput = struct {
    /// The name of the payment credential provider to retrieve.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};

pub const GetPaymentCredentialProviderOutput = struct {
    /// The timestamp when the payment credential provider was created.
    created_time: i64,

    /// The Amazon Resource Name (ARN) of the payment credential provider.
    credential_provider_arn: []const u8,

    credential_provider_vendor: PaymentCredentialProviderVendorType,

    /// The timestamp when the payment credential provider was last updated.
    last_updated_time: i64,

    /// The name of the payment credential provider.
    name: []const u8,

    /// Output configuration (contains secret ARNs, excludes actual secret values)
    provider_configuration_output: ?PaymentProviderConfigurationOutput = null,

    /// The tags associated with the payment credential provider.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_time = "createdTime",
        .credential_provider_arn = "credentialProviderArn",
        .credential_provider_vendor = "credentialProviderVendor",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
        .provider_configuration_output = "providerConfigurationOutput",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPaymentCredentialProviderInput, options: CallOptions) !GetPaymentCredentialProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPaymentCredentialProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/identities/GetPaymentCredentialProvider";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPaymentCredentialProviderOutput {
    var result: GetPaymentCredentialProviderOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPaymentCredentialProviderOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
