const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateGroupCertificateConfigurationInput = struct {
    /// The amount of time remaining before the certificate expires, in
    /// milliseconds.
    certificate_expiry_in_milliseconds: ?[]const u8 = null,

    /// The ID of the Greengrass group.
    group_id: []const u8,

    pub const json_field_names = .{
        .certificate_expiry_in_milliseconds = "CertificateExpiryInMilliseconds",
        .group_id = "GroupId",
    };
};

pub const UpdateGroupCertificateConfigurationOutput = struct {
    /// The amount of time remaining before the certificate authority expires, in
    /// milliseconds.
    certificate_authority_expiry_in_milliseconds: ?[]const u8 = null,

    /// The amount of time remaining before the certificate expires, in
    /// milliseconds.
    certificate_expiry_in_milliseconds: ?[]const u8 = null,

    /// The ID of the group certificate configuration.
    group_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_authority_expiry_in_milliseconds = "CertificateAuthorityExpiryInMilliseconds",
        .certificate_expiry_in_milliseconds = "CertificateExpiryInMilliseconds",
        .group_id = "GroupId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGroupCertificateConfigurationInput, options: CallOptions) !UpdateGroupCertificateConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "greengrass", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGroupCertificateConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "Greengrass", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/greengrass/groups/");
    try path_buf.appendSlice(allocator, input.group_id);
    try path_buf.appendSlice(allocator, "/certificateauthorities/configuration/expiry");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.certificate_expiry_in_milliseconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CertificateExpiryInMilliseconds\":");
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
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGroupCertificateConfigurationOutput {
    const result: UpdateGroupCertificateConfigurationOutput = try aws.json.parseJsonObject(
        UpdateGroupCertificateConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
