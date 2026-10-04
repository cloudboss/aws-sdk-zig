const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateMode = @import("certificate_mode.zig").CertificateMode;
const RegistrationConfig = @import("registration_config.zig").RegistrationConfig;
const Tag = @import("tag.zig").Tag;

pub const RegisterCACertificateInput = struct {
    /// Allows this CA certificate to be used for auto registration of device
    /// certificates.
    allow_auto_registration: ?bool = null,

    /// The CA certificate.
    ca_certificate: []const u8,

    /// Describes the certificate mode in which the Certificate Authority (CA) will
    /// be
    /// registered. If the `verificationCertificate` field is not provided, set
    /// `certificateMode` to be `SNI_ONLY`.
    /// If the `verificationCertificate` field is provided, set `certificateMode` to
    /// be `DEFAULT`.
    /// When `certificateMode` is not provided, it defaults to `DEFAULT`.
    /// All the device certificates that are registered using this CA will be
    /// registered in the same certificate mode as the CA.
    /// For more information about certificate mode for device certificates, see
    /// [
    /// certificate
    /// mode](https://docs.aws.amazon.com/iot/latest/apireference/API_CertificateDescription.html#iot-Type-CertificateDescription-certificateMode).
    certificate_mode: ?CertificateMode = null,

    /// Information about the registration configuration.
    registration_config: ?RegistrationConfig = null,

    /// A boolean value that specifies if the CA certificate is set to active.
    ///
    /// Valid values: `ACTIVE | INACTIVE`
    set_as_active: ?bool = null,

    /// Metadata which can be used to manage the CA certificate.
    ///
    /// For URI Request parameters use format: ...key1=value1&key2=value2...
    ///
    /// For the CLI command-line parameter use format: &&tags
    /// "key1=value1&key2=value2..."
    ///
    /// For the cli-input-json file use format: "tags":
    /// "key1=value1&key2=value2..."
    tags: ?[]const Tag = null,

    /// The private key verification certificate. If `certificateMode` is
    /// `SNI_ONLY`, the `verificationCertificate` field must be empty. If
    /// `certificateMode` is `DEFAULT` or not provided, the
    /// `verificationCertificate` field must not be empty.
    verification_certificate: ?[]const u8 = null,

    pub const json_field_names = .{
        .allow_auto_registration = "allowAutoRegistration",
        .ca_certificate = "caCertificate",
        .certificate_mode = "certificateMode",
        .registration_config = "registrationConfig",
        .set_as_active = "setAsActive",
        .tags = "tags",
        .verification_certificate = "verificationCertificate",
    };
};

pub const RegisterCACertificateOutput = struct {
    /// The CA certificate ARN.
    certificate_arn: ?[]const u8 = null,

    /// The CA certificate identifier.
    certificate_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
        .certificate_id = "certificateId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterCACertificateInput, options: CallOptions) !RegisterCACertificateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterCACertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/cacertificate";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.allow_auto_registration) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "allowAutoRegistration=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
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
    try body_buf.appendSlice(allocator, "\"caCertificate\":");
    try aws.json.writeValue(@TypeOf(input.ca_certificate), input.ca_certificate, allocator, &body_buf);
    has_prev = true;
    if (input.certificate_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"certificateMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.registration_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"registrationConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.verification_certificate) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"verificationCertificate\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterCACertificateOutput {
    var result: RegisterCACertificateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterCACertificateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
