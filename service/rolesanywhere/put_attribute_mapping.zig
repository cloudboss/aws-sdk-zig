const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateField = @import("certificate_field.zig").CertificateField;
const MappingRule = @import("mapping_rule.zig").MappingRule;
const ProfileDetail = @import("profile_detail.zig").ProfileDetail;

pub const PutAttributeMappingInput = struct {
    /// Fields (x509Subject, x509Issuer and x509SAN) within X.509 certificates.
    certificate_field: CertificateField,

    /// A list of mapping entries for every supported specifier or sub-field.
    mapping_rules: []const MappingRule,

    /// The unique identifier of the profile.
    profile_id: []const u8,

    pub const json_field_names = .{
        .certificate_field = "certificateField",
        .mapping_rules = "mappingRules",
        .profile_id = "profileId",
    };
};

pub const PutAttributeMappingOutput = struct {
    /// The state of the profile after a read or write operation.
    profile: ?ProfileDetail = null,

    pub const json_field_names = .{
        .profile = "profile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAttributeMappingInput, options: CallOptions) !PutAttributeMappingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAttributeMappingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rolesanywhere", "RolesAnywhere", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/profiles/");
    try path_buf.appendSlice(allocator, input.profile_id);
    try path_buf.appendSlice(allocator, "/mappings");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"certificateField\":");
    try aws.json.writeValue(@TypeOf(input.certificate_field), input.certificate_field, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"mappingRules\":");
    try aws.json.writeValue(@TypeOf(input.mapping_rules), input.mapping_rules, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAttributeMappingOutput {
    var result: PutAttributeMappingOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutAttributeMappingOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
