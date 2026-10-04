const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Catalog = @import("catalog.zig").Catalog;

pub const GetCatalogsInput = struct {
    /// When `true`, the response only includes catalogs that can contain databases.
    /// Some catalogs are organizational containers that hold only other catalogs,
    /// not databases. When this parameter is set to `true`, those container-only
    /// catalogs are excluded, and only catalogs capable of containing databases are
    /// returned. Defaults to `false`.
    has_databases: ?bool = null,

    /// Whether to list the default catalog in the account and region in the
    /// response. Defaults to `false`. When `true` and `ParentCatalogId = NULL |
    /// Amazon Web Services Account ID`, all catalogs and the default catalog are
    /// enumerated in the response.
    ///
    /// When the `ParentCatalogId` is not equal to null, and this attribute is
    /// passed as `false` or `true`, an `InvalidInputException` is thrown.
    include_root: ?bool = null,

    /// The maximum number of catalogs to return in one response.
    max_results: ?i32 = null,

    /// A continuation token, if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// The ID of the parent catalog in which the catalog resides. If none is
    /// provided, the Amazon Web Services Account Number is used by default.
    parent_catalog_id: ?[]const u8 = null,

    /// Whether to list all catalogs across the catalog hierarchy, starting from the
    /// `ParentCatalogId`. Defaults to `false` . When `true`, all catalog objects in
    /// the `ParentCatalogID` hierarchy are enumerated in the response.
    recursive: ?bool = null,

    pub const json_field_names = .{
        .has_databases = "HasDatabases",
        .include_root = "IncludeRoot",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .parent_catalog_id = "ParentCatalogId",
        .recursive = "Recursive",
    };
};

pub const GetCatalogsOutput = struct {
    /// An array of `Catalog` objects. A list of `Catalog` objects from the
    /// specified parent catalog.
    catalog_list: ?[]const Catalog = null,

    /// A continuation token for paginating the returned list of tokens, returned if
    /// the current segment of the list is not the last.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_list = "CatalogList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCatalogsInput, options: CallOptions) !GetCatalogsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCatalogsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetCatalogs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCatalogsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetCatalogsOutput, body, allocator);
}
