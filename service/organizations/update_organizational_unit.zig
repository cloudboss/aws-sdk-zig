const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrganizationalUnit = @import("organizational_unit.zig").OrganizationalUnit;

pub const UpdateOrganizationalUnitInput = struct {
    /// The new name that you want to assign to the OU.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex)
    /// that is used to validate this parameter is a string of any of the characters
    /// in the ASCII
    /// character range.
    name: ?[]const u8 = null,

    /// ID for the OU that you want to rename. You can get the ID from the
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
        .name = "Name",
        .organizational_unit_id = "OrganizationalUnitId",
    };
};

pub const UpdateOrganizationalUnitOutput = struct {
    /// A structure that contains the details about the specified OU, including its
    /// new
    /// name.
    organizational_unit: ?OrganizationalUnit = null,

    pub const json_field_names = .{
        .organizational_unit = "OrganizationalUnit",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateOrganizationalUnitInput, options: CallOptions) !UpdateOrganizationalUnitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateOrganizationalUnitInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.UpdateOrganizationalUnit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateOrganizationalUnitOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateOrganizationalUnitOutput, body, allocator);
}
