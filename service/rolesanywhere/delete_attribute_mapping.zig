const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateField = @import("certificate_field.zig").CertificateField;
const ProfileDetail = @import("profile_detail.zig").ProfileDetail;

pub const DeleteAttributeMappingInput = struct {
    /// Fields (x509Subject, x509Issuer and x509SAN) within X.509 certificates.
    certificate_field: CertificateField,

    /// The unique identifier of the profile.
    profile_id: []const u8,

    /// A list of specifiers of a certificate field; for example, CN, OU, UID from a
    /// Subject.
    specifiers: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .certificate_field = "certificateField",
        .profile_id = "profileId",
        .specifiers = "specifiers",
    };
};

pub const DeleteAttributeMappingOutput = struct {
    /// The state of the profile after a read or write operation.
    profile: ?ProfileDetail = null,

    pub const json_field_names = .{
        .profile = "profile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAttributeMappingInput, options: CallOptions) !DeleteAttributeMappingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rolesanywhere", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAttributeMappingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rolesanywhere", "RolesAnywhere", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/profiles/");
    try path_buf.appendSlice(allocator, input.profile_id);
    try path_buf.appendSlice(allocator, "/mappings");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "certificateField=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.certificate_field.wireName());
    query_has_prev = true;
    if (input.specifiers) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "specifiers=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAttributeMappingOutput {
    var result: DeleteAttributeMappingOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteAttributeMappingOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
