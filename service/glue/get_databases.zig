const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatabaseAttributes = @import("database_attributes.zig").DatabaseAttributes;
const ResourceShareType = @import("resource_share_type.zig").ResourceShareType;
const Database = @import("database.zig").Database;

pub const GetDatabasesInput = struct {
    /// Specifies the database fields returned by the `GetDatabases` call. This
    /// parameter doesn’t accept an empty list. The request must include the `NAME`.
    attributes_to_get: ?[]const DatabaseAttributes = null,

    /// The ID of the Data Catalog from which to retrieve `Databases`. If none is
    /// provided, the Amazon Web Services account ID is used by default.
    catalog_id: ?[]const u8 = null,

    /// The maximum number of databases to return in one response.
    max_results: ?i32 = null,

    /// A continuation token, if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// Allows you to specify that you want to list the databases shared with your
    /// account. The allowable values are `FEDERATED`, `FOREIGN` or `ALL`.
    ///
    /// * If set to `FEDERATED`, will list the federated databases (referencing an
    ///   external entity) shared with your account.
    ///
    /// * If set to `FOREIGN`, will list the databases shared with your account.
    ///
    /// * If set to `ALL`, will list the databases shared with your account, as well
    ///   as the databases in yor local account.
    resource_share_type: ?ResourceShareType = null,

    pub const json_field_names = .{
        .attributes_to_get = "AttributesToGet",
        .catalog_id = "CatalogId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_share_type = "ResourceShareType",
    };
};

pub const GetDatabasesOutput = struct {
    /// A list of `Database` objects from the specified catalog.
    database_list: ?[]const Database = null,

    /// A continuation token for paginating the returned list of tokens,
    /// returned if the current segment of the list is not the last.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .database_list = "DatabaseList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDatabasesInput, options: CallOptions) !GetDatabasesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDatabasesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetDatabases");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDatabasesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetDatabasesOutput, body, allocator);
}
