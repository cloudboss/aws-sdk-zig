const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateStatus = @import("certificate_status.zig").CertificateStatus;

pub const UpdateCertificateInput = struct {
    /// The ID of the certificate. (The last part of the certificate ARN contains
    /// the
    /// certificate ID.)
    certificate_id: []const u8,

    /// The new status.
    ///
    /// **Note:** Setting the status to PENDING_TRANSFER or PENDING_ACTIVATION will
    /// result
    /// in an exception being thrown. PENDING_TRANSFER and PENDING_ACTIVATION are
    /// statuses used internally by IoT. They
    /// are not intended for developer use.
    ///
    /// **Note:** The status value REGISTER_INACTIVE is deprecated and
    /// should not be used.
    new_status: CertificateStatus,

    pub const json_field_names = .{
        .certificate_id = "certificateId",
        .new_status = "newStatus",
    };
};

pub const UpdateCertificateOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCertificateInput, options: CallOptions) !UpdateCertificateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/certificates/");
    try path_buf.appendSlice(allocator, input.certificate_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "newStatus=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.new_status.wireName());
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCertificateOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateCertificateOutput = .{};

    return result;
}
