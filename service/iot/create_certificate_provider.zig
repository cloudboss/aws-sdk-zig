const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateProviderOperation = @import("certificate_provider_operation.zig").CertificateProviderOperation;
const Tag = @import("tag.zig").Tag;

pub const CreateCertificateProviderInput = struct {
    /// A list of the operations that the certificate provider will use to generate
    /// certificates.
    /// Valid value: `CreateCertificateFromCsr`.
    account_default_for_operations: []const CertificateProviderOperation,

    /// The name of the certificate provider.
    certificate_provider_name: []const u8,

    /// A string that you can optionally pass in the `CreateCertificateProvider`
    /// request to make sure
    /// the request is idempotent.
    client_token: ?[]const u8 = null,

    /// The ARN of the Lambda function that defines the authentication logic.
    lambda_function_arn: []const u8,

    /// Metadata which can be used to manage the certificate provider.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .account_default_for_operations = "accountDefaultForOperations",
        .certificate_provider_name = "certificateProviderName",
        .client_token = "clientToken",
        .lambda_function_arn = "lambdaFunctionArn",
        .tags = "tags",
    };
};

pub const CreateCertificateProviderOutput = struct {
    /// The ARN of the certificate provider.
    certificate_provider_arn: ?[]const u8 = null,

    /// The name of the certificate provider.
    certificate_provider_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_provider_arn = "certificateProviderArn",
        .certificate_provider_name = "certificateProviderName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCertificateProviderInput, options: CallOptions) !CreateCertificateProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCertificateProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/certificate-providers/");
    try path_buf.appendSlice(allocator, input.certificate_provider_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"accountDefaultForOperations\":");
    try aws.json.writeValue(@TypeOf(input.account_default_for_operations), input.account_default_for_operations, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"lambdaFunctionArn\":");
    try aws.json.writeValue(@TypeOf(input.lambda_function_arn), input.lambda_function_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCertificateProviderOutput {
    const result: CreateCertificateProviderOutput = try aws.json.parseJsonObject(
        CreateCertificateProviderOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
