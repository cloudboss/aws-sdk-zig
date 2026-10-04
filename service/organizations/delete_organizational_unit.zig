const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteOrganizationalUnitInput = struct {
    /// ID for the organizational unit that you want to delete. You can get the ID
    /// from the
    /// ListOrganizationalUnitsForParent operation.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for an organizational
    /// unit ID string requires
    /// "ou-" followed by from 4 to 32 lowercase letters or digits (the ID of the
    /// root that contains the
    /// OU). This string is followed by a second "-" dash and from 8 to 32
    /// additional lowercase letters
    /// or digits.
    organizational_unit_id: []const u8,

    pub const json_field_names = .{
        .organizational_unit_id = "OrganizationalUnitId",
    };
};

pub const DeleteOrganizationalUnitOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteOrganizationalUnitInput, options: CallOptions) !DeleteOrganizationalUnitOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "organizations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteOrganizationalUnitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("organizations", "Organizations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.DeleteOrganizationalUnit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteOrganizationalUnitOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
