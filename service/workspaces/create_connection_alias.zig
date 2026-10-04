const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateConnectionAliasInput = struct {
    /// A connection string in the form of a fully qualified domain name (FQDN),
    /// such as
    /// `www.example.com`.
    ///
    /// After you create a connection string, it is always associated to your Amazon
    /// Web Services account. You cannot recreate the same connection string with a
    /// different
    /// account, even if you delete all instances of it from the original account.
    /// The
    /// connection string is globally reserved for your account.
    connection_string: []const u8,

    /// The tags to associate with the connection alias.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .connection_string = "ConnectionString",
        .tags = "Tags",
    };
};

pub const CreateConnectionAliasOutput = struct {
    /// The identifier of the connection alias.
    alias_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias_id = "AliasId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectionAliasInput, options: CallOptions) !CreateConnectionAliasOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectionAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces", "WorkSpaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.CreateConnectionAlias");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectionAliasOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateConnectionAliasOutput, body, allocator);
}
