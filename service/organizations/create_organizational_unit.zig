const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const OrganizationalUnit = @import("organizational_unit.zig").OrganizationalUnit;

pub const CreateOrganizationalUnitInput = struct {
    /// The friendly name to assign to the new OU.
    name: []const u8,

    /// ID for the parent root or OU that you want to create the new OU in.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for a parent ID string
    /// requires one of the
    /// following:
    ///
    /// * **Root** - A string that begins with "r-" followed by from 4 to 32
    ///   lowercase letters or
    /// digits.
    ///
    /// * **Organizational unit (OU)** - A string that begins with "ou-" followed by
    ///   from 4 to 32
    /// lowercase letters or digits (the ID of the root that the OU is in). This
    /// string is followed by a second
    /// "-" dash and from 8 to 32 additional lowercase letters or digits.
    parent_id: []const u8,

    /// A list of tags that you want to attach to the newly created OU. For each tag
    /// in the
    /// list, you must specify both a tag key and a value. You can set the value to
    /// an empty
    /// string, but you can't set it to `null`. For more information about tagging,
    /// see [Tagging Organizations
    /// resources](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_tagging.html) in the Organizations User Guide.
    ///
    /// If any one of the tags is not valid or if you exceed the allowed number of
    /// tags
    /// for an OU, then the entire request fails and the OU is not created.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .name = "Name",
        .parent_id = "ParentId",
        .tags = "Tags",
    };
};

pub const CreateOrganizationalUnitOutput = struct {
    /// A structure that contains details about the newly created OU.
    organizational_unit: ?OrganizationalUnit = null,

    pub const json_field_names = .{
        .organizational_unit = "OrganizationalUnit",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOrganizationalUnitInput, options: CallOptions) !CreateOrganizationalUnitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOrganizationalUnitInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.CreateOrganizationalUnit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOrganizationalUnitOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateOrganizationalUnitOutput, body, allocator);
}
