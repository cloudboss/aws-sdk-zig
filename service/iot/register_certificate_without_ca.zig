const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateStatus = @import("certificate_status.zig").CertificateStatus;

pub const RegisterCertificateWithoutCAInput = struct {
    /// The certificate data, in PEM format.
    certificate_pem: []const u8,

    /// The status of the register certificate request.
    status: ?CertificateStatus = null,

    pub const json_field_names = .{
        .certificate_pem = "certificatePem",
        .status = "status",
    };
};

pub const RegisterCertificateWithoutCAOutput = struct {
    /// The Amazon Resource Name (ARN) of the registered certificate.
    certificate_arn: ?[]const u8 = null,

    /// The ID of the registered certificate. (The last part of the certificate ARN
    /// contains the
    /// certificate ID.
    certificate_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
        .certificate_id = "certificateId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterCertificateWithoutCAInput, options: CallOptions) !RegisterCertificateWithoutCAOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterCertificateWithoutCAInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/certificate/register-no-ca";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"certificatePem\":");
    try aws.json.writeValue(@TypeOf(input.certificate_pem), input.certificate_pem, allocator, &body_buf);
    has_prev = true;
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterCertificateWithoutCAOutput {
    var result: RegisterCertificateWithoutCAOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterCertificateWithoutCAOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
