const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RegisterToWorkMailInput = struct {
    /// The email for the user, group, or resource to be updated.
    email: []const u8,

    /// The identifier for the user, group, or resource to be updated.
    ///
    /// The identifier can accept *UserId, ResourceId, or GroupId*, or *Username,
    /// Resourcename, or Groupname*. The following identity formats are available:
    ///
    /// * Entity ID: 12345678-1234-1234-1234-123456789012,
    ///   r-0123456789a0123456789b0123456789, or
    ///   S-1-1-12-1234567890-123456789-123456789-1234
    ///
    /// * Entity name: entity
    entity_id: []const u8,

    /// The identifier for the organization under which the user, group, or resource
    /// exists.
    organization_id: []const u8,

    pub const json_field_names = .{
        .email = "Email",
        .entity_id = "EntityId",
        .organization_id = "OrganizationId",
    };
};

pub const RegisterToWorkMailOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterToWorkMailInput, options: CallOptions) !RegisterToWorkMailOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterToWorkMailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.RegisterToWorkMail");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterToWorkMailOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
