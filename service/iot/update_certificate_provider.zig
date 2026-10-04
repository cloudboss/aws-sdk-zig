const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateProviderOperation = @import("certificate_provider_operation.zig").CertificateProviderOperation;

pub const UpdateCertificateProviderInput = struct {
    /// A list of the operations that the certificate provider will use to generate
    /// certificates.
    /// Valid value: `CreateCertificateFromCsr`.
    account_default_for_operations: ?[]const CertificateProviderOperation = null,

    /// The name of the certificate provider.
    certificate_provider_name: []const u8,

    /// The Lambda function ARN that's associated with the certificate provider.
    lambda_function_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_default_for_operations = "accountDefaultForOperations",
        .certificate_provider_name = "certificateProviderName",
        .lambda_function_arn = "lambdaFunctionArn",
    };
};

pub const UpdateCertificateProviderOutput = struct {
    /// The ARN of the certificate provider.
    certificate_provider_arn: ?[]const u8 = null,

    /// The name of the certificate provider.
    certificate_provider_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_provider_arn = "certificateProviderArn",
        .certificate_provider_name = "certificateProviderName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCertificateProviderInput, options: CallOptions) !UpdateCertificateProviderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCertificateProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/certificate-providers/");
    try path_buf.appendSlice(allocator, input.certificate_provider_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_default_for_operations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountDefaultForOperations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.lambda_function_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"lambdaFunctionArn\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCertificateProviderOutput {
    var result: UpdateCertificateProviderOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateCertificateProviderOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
