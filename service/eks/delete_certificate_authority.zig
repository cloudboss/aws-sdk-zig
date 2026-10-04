const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateAuthoritySummary = @import("certificate_authority_summary.zig").CertificateAuthoritySummary;
const Update = @import("update.zig").Update;

pub const DeleteCertificateAuthorityInput = struct {
    /// The ID of the certificate authority to delete. You can't delete the
    /// certificate
    /// authority that's currently signing certificates for the cluster.
    certificate_authority_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure
    /// the idempotency of the request.
    client_request_token: ?[]const u8 = null,

    /// The name of your cluster.
    cluster_name: []const u8,

    pub const json_field_names = .{
        .certificate_authority_id = "certificateAuthorityId",
        .client_request_token = "clientRequestToken",
        .cluster_name = "clusterName",
    };
};

pub const DeleteCertificateAuthorityOutput = struct {
    /// Summary information about the certificate authority that is being deleted.
    certificate_authority: ?CertificateAuthoritySummary = null,

    /// An object representing the asynchronous update that removes the certificate
    /// authority
    /// from the cluster's trust bundle.
    update: ?Update = null,

    pub const json_field_names = .{
        .certificate_authority = "certificateAuthority",
        .update = "update",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteCertificateAuthorityInput, options: CallOptions) !DeleteCertificateAuthorityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "eks", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteCertificateAuthorityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/certificate-authorities/");
    try path_buf.appendSlice(allocator, input.certificate_authority_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.client_request_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientRequestToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteCertificateAuthorityOutput {
    const result: DeleteCertificateAuthorityOutput = try aws.json.parseJsonObject(
        DeleteCertificateAuthorityOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
