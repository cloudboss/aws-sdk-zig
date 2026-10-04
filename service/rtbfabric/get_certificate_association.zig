const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateAssociationStatus = @import("certificate_association_status.zig").CertificateAssociationStatus;

pub const GetCertificateAssociationInput = struct {
    /// The Amazon Resource Name (ARN) of the ACM certificate.
    acm_certificate_arn: []const u8,

    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    pub const json_field_names = .{
        .acm_certificate_arn = "acmCertificateArn",
        .gateway_id = "gatewayId",
    };
};

pub const GetCertificateAssociationOutput = struct {
    /// The Amazon Resource Name (ARN) of the ACM certificate.
    acm_certificate_arn: []const u8,

    /// The timestamp of when the certificate was associated.
    associated_at: ?i64 = null,

    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The status of the certificate association.
    status: CertificateAssociationStatus,

    /// The timestamp of when the certificate association was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .acm_certificate_arn = "acmCertificateArn",
        .associated_at = "associatedAt",
        .gateway_id = "gatewayId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCertificateAssociationInput, options: CallOptions) !GetCertificateAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rtbfabric", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCertificateAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rtbfabric", "RTBFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/responder-gateway/");
    try path_buf.appendSlice(allocator, input.gateway_id);
    try path_buf.appendSlice(allocator, "/certificate");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "acmCertificateArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.acm_certificate_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCertificateAssociationOutput {
    const result: GetCertificateAssociationOutput = try aws.json.parseJsonObject(
        GetCertificateAssociationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
