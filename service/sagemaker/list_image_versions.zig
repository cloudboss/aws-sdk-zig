const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageVersionSortBy = @import("image_version_sort_by.zig").ImageVersionSortBy;
const ImageVersionSortOrder = @import("image_version_sort_order.zig").ImageVersionSortOrder;
const ImageVersion = @import("image_version.zig").ImageVersion;

pub const ListImageVersionsInput = struct {
    /// A filter that returns only versions created on or after the specified time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only versions created on or before the specified time.
    creation_time_before: ?i64 = null,

    /// The name of the image to list the versions of.
    image_name: []const u8,

    /// A filter that returns only versions modified on or after the specified time.
    last_modified_time_after: ?i64 = null,

    /// A filter that returns only versions modified on or before the specified
    /// time.
    last_modified_time_before: ?i64 = null,

    /// The maximum number of versions to return in the response. The default value
    /// is 10.
    max_results: ?i32 = null,

    /// If the previous call to `ListImageVersions` didn't return the full set of
    /// versions, the call returns a token for getting the next set of versions.
    next_token: ?[]const u8 = null,

    /// The property used to sort results. The default value is `CREATION_TIME`.
    sort_by: ?ImageVersionSortBy = null,

    /// The sort order. The default value is `DESCENDING`.
    sort_order: ?ImageVersionSortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .image_name = "ImageName",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListImageVersionsOutput = struct {
    /// A list of versions and their properties.
    image_versions: ?[]const ImageVersion = null,

    /// A token for getting the next set of versions, if there are any.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_versions = "ImageVersions",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListImageVersionsInput, options: CallOptions) !ListImageVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListImageVersionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListImageVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListImageVersionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListImageVersionsOutput, body, allocator);
}
