const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceCatalogSortBy = @import("resource_catalog_sort_by.zig").ResourceCatalogSortBy;
const ResourceCatalogSortOrder = @import("resource_catalog_sort_order.zig").ResourceCatalogSortOrder;
const ResourceCatalog = @import("resource_catalog.zig").ResourceCatalog;

pub const ListResourceCatalogsInput = struct {
    /// Use this parameter to search for `ResourceCatalog`s created after a specific
    /// date and time.
    creation_time_after: ?i64 = null,

    /// Use this parameter to search for `ResourceCatalog`s created before a
    /// specific date and time.
    creation_time_before: ?i64 = null,

    /// The maximum number of results returned by `ListResourceCatalogs`.
    max_results: ?i32 = null,

    /// A string that partially matches one or more `ResourceCatalog`s names.
    /// Filters `ResourceCatalog` by name.
    name_contains: ?[]const u8 = null,

    /// A token to resume pagination of `ListResourceCatalogs` results.
    next_token: ?[]const u8 = null,

    /// The value on which the resource catalog list is sorted.
    sort_by: ?ResourceCatalogSortBy = null,

    /// The order in which the resource catalogs are listed.
    sort_order: ?ResourceCatalogSortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListResourceCatalogsOutput = struct {
    /// A token to resume pagination of `ListResourceCatalogs` results.
    next_token: ?[]const u8 = null,

    /// A list of the requested `ResourceCatalog`s.
    resource_catalogs: ?[]const ResourceCatalog = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_catalogs = "ResourceCatalogs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourceCatalogsInput, options: CallOptions) !ListResourceCatalogsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourceCatalogsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListResourceCatalogs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourceCatalogsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListResourceCatalogsOutput, body, allocator);
}
