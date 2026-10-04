const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainAssociation = @import("domain_association.zig").DomainAssociation;

pub const GetDomainAssociationInput = struct {
    /// The unique id for an Amplify app.
    app_id: []const u8,

    /// The name of the domain.
    domain_name: []const u8,

    pub const json_field_names = .{
        .app_id = "appId",
        .domain_name = "domainName",
    };
};

pub const GetDomainAssociationOutput = struct {
    /// Describes the structure of a domain association, which associates a custom
    /// domain
    /// with an Amplify app.
    domain_association: ?DomainAssociation = null,

    pub const json_field_names = .{
        .domain_association = "domainAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDomainAssociationInput, options: CallOptions) !GetDomainAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amplify", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDomainAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amplify", "Amplify", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/apps/");
    try path_buf.appendSlice(allocator, input.app_id);
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDomainAssociationOutput {
    var result: GetDomainAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDomainAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
