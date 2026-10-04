const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const VerifyProcurementPortalValidationInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure idempotency
    /// of the request.
    client_token: ?[]const u8 = null,

    /// The validation code received from the procurement portal in response to a
    /// previous `SendProcurementPortalValidation` request.
    code: []const u8,

    /// The Amazon Resource Name (ARN) of the procurement portal preference to
    /// validate.
    procurement_portal_preference_arn: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .code = "Code",
        .procurement_portal_preference_arn = "ProcurementPortalPreferenceArn",
    };
};

pub const VerifyProcurementPortalValidationOutput = struct {
    /// The Amazon Resource Name (ARN) of the procurement portal preference for
    /// which validation was completed.
    procurement_portal_preference_arn: []const u8,

    pub const json_field_names = .{
        .procurement_portal_preference_arn = "ProcurementPortalPreferenceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: VerifyProcurementPortalValidationInput, options: CallOptions) !VerifyProcurementPortalValidationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "invoicing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: VerifyProcurementPortalValidationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("invoicing", "Invoicing", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Invoicing.VerifyProcurementPortalValidation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !VerifyProcurementPortalValidationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(VerifyProcurementPortalValidationOutput, body, allocator);
}
