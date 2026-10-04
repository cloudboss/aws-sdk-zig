const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageSortBy = @import("image_sort_by.zig").ImageSortBy;
const ImageSortOrder = @import("image_sort_order.zig").ImageSortOrder;
const Image = @import("image.zig").Image;

pub const ListImagesInput = struct {
    /// A filter that returns only images created on or after the specified time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only images created on or before the specified time.
    creation_time_before: ?i64 = null,

    /// A filter that returns only images modified on or after the specified time.
    last_modified_time_after: ?i64 = null,

    /// A filter that returns only images modified on or before the specified time.
    last_modified_time_before: ?i64 = null,

    /// The maximum number of images to return in the response. The default value is
    /// 10.
    max_results: ?i32 = null,

    /// A filter that returns only images whose name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the previous call to `ListImages` didn't return the full set of images,
    /// the call returns a token for getting the next set of images.
    next_token: ?[]const u8 = null,

    /// The property used to sort results. The default value is `CREATION_TIME`.
    sort_by: ?ImageSortBy = null,

    /// The sort order. The default value is `DESCENDING`.
    sort_order: ?ImageSortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListImagesOutput = struct {
    /// A list of images and their properties.
    images: ?[]const Image = null,

    /// A token for getting the next set of images, if there are any.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .images = "Images",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListImagesInput, options: CallOptions) !ListImagesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListImagesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListImages");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListImagesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListImagesOutput, body, allocator);
}
