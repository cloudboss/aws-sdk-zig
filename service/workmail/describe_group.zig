const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntityState = @import("entity_state.zig").EntityState;

pub const DescribeGroupInput = struct {
    /// The identifier for the group to be described.
    ///
    /// The identifier can accept *GroupId*, *Groupname*, or *email*. The following
    /// identity formats are available:
    ///
    /// * Group ID: 12345678-1234-1234-1234-123456789012 or
    ///   S-1-1-12-1234567890-123456789-123456789-1234
    ///
    /// * Email address: group@domain.tld
    ///
    /// * Group name: group
    group_id: []const u8,

    /// The identifier for the organization under which the group exists.
    organization_id: []const u8,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .organization_id = "OrganizationId",
    };
};

pub const DescribeGroupOutput = struct {
    /// The date and time when a user was deregistered from WorkMail, in UNIX epoch
    /// time
    /// format.
    disabled_date: ?i64 = null,

    /// The email of the described group.
    email: ?[]const u8 = null,

    /// The date and time when a user was registered to WorkMail, in UNIX epoch time
    /// format.
    enabled_date: ?i64 = null,

    /// The identifier of the described group.
    group_id: ?[]const u8 = null,

    /// If the value is set to *true*, the group is hidden from the address book.
    hidden_from_global_address_list: ?bool = null,

    /// The name of the described group.
    name: ?[]const u8 = null,

    /// The state of the user: enabled (registered to WorkMail) or disabled
    /// (deregistered or
    /// never registered to WorkMail).
    state: ?EntityState = null,

    pub const json_field_names = .{
        .disabled_date = "DisabledDate",
        .email = "Email",
        .enabled_date = "EnabledDate",
        .group_id = "GroupId",
        .hidden_from_global_address_list = "HiddenFromGlobalAddressList",
        .name = "Name",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeGroupInput, options: CallOptions) !DescribeGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.DescribeGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeGroupOutput, body, allocator);
}
