const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoRegistrationStatus = @import("auto_registration_status.zig").AutoRegistrationStatus;
const CACertificateStatus = @import("ca_certificate_status.zig").CACertificateStatus;
const RegistrationConfig = @import("registration_config.zig").RegistrationConfig;

pub const UpdateCACertificateInput = struct {
    /// The CA certificate identifier.
    certificate_id: []const u8,

    /// The new value for the auto registration status. Valid values are: "ENABLE"
    /// or
    /// "DISABLE".
    new_auto_registration_status: ?AutoRegistrationStatus = null,

    /// The updated status of the CA certificate.
    ///
    /// **Note:** The status value REGISTER_INACTIVE is deprecated and
    /// should not be used.
    new_status: ?CACertificateStatus = null,

    /// Information about the registration configuration.
    registration_config: ?RegistrationConfig = null,

    /// If true, removes auto registration.
    remove_auto_registration: ?bool = null,

    pub const json_field_names = .{
        .certificate_id = "certificateId",
        .new_auto_registration_status = "newAutoRegistrationStatus",
        .new_status = "newStatus",
        .registration_config = "registrationConfig",
        .remove_auto_registration = "removeAutoRegistration",
    };
};

pub const UpdateCACertificateOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCACertificateInput, options: CallOptions) !UpdateCACertificateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCACertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/cacertificate/");
    try path_buf.appendSlice(allocator, input.certificate_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.new_auto_registration_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "newAutoRegistrationStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.new_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "newStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.registration_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"registrationConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.remove_auto_registration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"removeAutoRegistration\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCACertificateOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateCACertificateOutput = .{};

    return result;
}
