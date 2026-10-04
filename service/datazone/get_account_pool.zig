const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountSource = @import("account_source.zig").AccountSource;
const ResolutionStrategy = @import("resolution_strategy.zig").ResolutionStrategy;

pub const GetAccountPoolInput = struct {
    /// The ID of the domain in which the account pool lives whose details are to be
    /// displayed.
    domain_identifier: []const u8,

    /// The ID of the account pool whose details are to be displayed.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
    };
};

pub const GetAccountPoolOutput = struct {
    /// The source of accounts for the account pool. In the current release, it's
    /// either a static list of accounts provided by the customer or a custom Amazon
    /// Web Services Lambda handler.
    account_source: ?AccountSource = null,

    /// The timestamp at which the account pool was created.
    created_at: ?i64 = null,

    /// The user who created the account pool.
    created_by: []const u8,

    /// The description of the account pool.
    description: ?[]const u8 = null,

    /// The ID of the domain in which the account pool lives whose details are to be
    /// displayed.
    domain_id: ?[]const u8 = null,

    /// The domain unit ID of the account pool.
    domain_unit_id: ?[]const u8 = null,

    /// The ID of the account pool.
    id: ?[]const u8 = null,

    /// The timestamp at which the account pool was last updated.
    last_updated_at: ?i64 = null,

    /// The name of the account pool.
    name: ?[]const u8 = null,

    /// The mechanism used to resolve the account selection from the account pool.
    resolution_strategy: ?ResolutionStrategy = null,

    /// The user who last updated the account pool.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_source = "accountSource",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .domain_unit_id = "domainUnitId",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .resolution_strategy = "resolutionStrategy",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccountPoolInput, options: CallOptions) !GetAccountPoolOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccountPoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/account-pools/");
    try path_buf.appendSlice(allocator, input.identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccountPoolOutput {
    const result: GetAccountPoolOutput = try aws.json.parseJsonObject(
        GetAccountPoolOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
