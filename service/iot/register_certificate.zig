const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateStatus = @import("certificate_status.zig").CertificateStatus;

pub const RegisterCertificateInput = struct {
    /// The CA certificate used to sign the device certificate being registered.
    ca_certificate_pem: ?[]const u8 = null,

    /// The certificate data, in PEM format.
    certificate_pem: []const u8,

    /// A boolean value that specifies if the certificate is set to active.
    ///
    /// Valid values: `ACTIVE | INACTIVE`
    set_as_active: ?bool = null,

    /// The status of the register certificate request. Valid values that you can
    /// use include
    /// `ACTIVE`, `INACTIVE`, and `REVOKED`.
    status: ?CertificateStatus = null,

    pub const json_field_names = .{
        .ca_certificate_pem = "caCertificatePem",
        .certificate_pem = "certificatePem",
        .set_as_active = "setAsActive",
        .status = "status",
    };
};

pub const RegisterCertificateOutput = struct {
    /// The certificate ARN.
    certificate_arn: ?[]const u8 = null,

    /// The certificate identifier.
    certificate_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
        .certificate_id = "certificateId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterCertificateInput, options: CallOptions) !RegisterCertificateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterCertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/certificate/register";

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

    if (input.ca_certificate_pem) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"caCertificatePem\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterCertificateOutput {
    var result: RegisterCertificateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterCertificateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
