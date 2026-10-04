const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateGroupCertificateAuthorityInput = struct {
    /// A client token used to correlate requests and responses.
    amzn_client_token: ?[]const u8 = null,

    /// The ID of the Greengrass group.
    group_id: []const u8,

    pub const json_field_names = .{
        .amzn_client_token = "AmznClientToken",
        .group_id = "GroupId",
    };
};

pub const CreateGroupCertificateAuthorityOutput = struct {
    /// The ARN of the group certificate authority.
    group_certificate_authority_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_certificate_authority_arn = "GroupCertificateAuthorityArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGroupCertificateAuthorityInput, options: CallOptions) !CreateGroupCertificateAuthorityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGroupCertificateAuthorityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "Greengrass", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/greengrass/groups/");
    try path_buf.appendSlice(allocator, input.group_id);
    try path_buf.appendSlice(allocator, "/certificateauthorities");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.amzn_client_token) |v| {
        try request.headers.put(allocator, "X-Amzn-Client-Token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGroupCertificateAuthorityOutput {
    const result: CreateGroupCertificateAuthorityOutput = try aws.json.parseJsonObject(
        CreateGroupCertificateAuthorityOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
