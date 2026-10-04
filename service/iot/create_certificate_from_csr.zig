const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateCertificateFromCsrInput = struct {
    /// The certificate signing request (CSR).
    certificate_signing_request: []const u8,

    /// Specifies whether the certificate is active.
    set_as_active: ?bool = null,

    pub const json_field_names = .{
        .certificate_signing_request = "certificateSigningRequest",
        .set_as_active = "setAsActive",
    };
};

pub const CreateCertificateFromCsrOutput = struct {
    /// The Amazon Resource Name (ARN) of the certificate. You can use the ARN as a
    /// principal
    /// for policy operations.
    certificate_arn: ?[]const u8 = null,

    /// The ID of the certificate. Certificate management operations only take a
    /// certificateId.
    certificate_id: ?[]const u8 = null,

    /// The certificate data, in PEM format.
    certificate_pem: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
        .certificate_id = "certificateId",
        .certificate_pem = "certificatePem",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCertificateFromCsrInput, options: CallOptions) !CreateCertificateFromCsrOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCertificateFromCsrInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/certificates";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.set_as_active) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "setAsActive=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"certificateSigningRequest\":");
    try aws.json.writeValue(@TypeOf(input.certificate_signing_request), input.certificate_signing_request, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCertificateFromCsrOutput {
    const result: CreateCertificateFromCsrOutput = try aws.json.parseJsonObject(
        CreateCertificateFromCsrOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
