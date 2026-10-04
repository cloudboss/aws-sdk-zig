const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageIdentifier = @import("image_identifier.zig").ImageIdentifier;
const ImageDetail = @import("image_detail.zig").ImageDetail;

pub const DescribeImagesInput = struct {
    /// The list of image IDs for the requested repository.
    image_ids: ?[]const ImageIdentifier = null,

    /// The maximum number of repository results that's returned by `DescribeImages`
    /// in paginated output. When this parameter is used, `DescribeImages` only
    /// returns
    /// `maxResults` results in a single page along with a `nextToken`
    /// response element. You can see the remaining results of the initial request
    /// by sending
    /// another `DescribeImages` request with the returned `nextToken` value.
    /// This value can be between 1 and 1000. If this parameter isn't
    /// used, then `DescribeImages` returns up to 100 results and a
    /// `nextToken` value, if applicable. If you specify images with
    /// `imageIds`, you can't use this option.
    max_results: ?i32 = null,

    /// The `nextToken` value that's returned from a previous paginated
    /// `DescribeImages` request where `maxResults` was used and the
    /// results exceeded the value of that parameter. Pagination continues from the
    /// end of the
    /// previous results that returned the `nextToken` value. If there are no more
    /// results to return, this value is `null`. If you specify images with
    /// `imageIds`, you can't use this option.
    next_token: ?[]const u8 = null,

    /// The Amazon Web Services account ID that's associated with the public
    /// registry that contains the
    /// repository where images are described. If you do not specify a registry, the
    /// default public registry is assumed.
    registry_id: ?[]const u8 = null,

    /// The repository that contains the images to describe.
    repository_name: []const u8,

    pub const json_field_names = .{
        .image_ids = "imageIds",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub const DescribeImagesOutput = struct {
    /// A list of ImageDetail objects that contain data about the
    /// image.
    image_details: ?[]const ImageDetail = null,

    /// The `nextToken` value to include in a future `DescribeImages`
    /// request. When the results of a `DescribeImages` request exceed
    /// `maxResults`, you can use this value to retrieve the next page of results.
    /// If
    /// there are no more results to return, this value is `null`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_details = "imageDetails",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeImagesInput, options: CallOptions) !DescribeImagesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecr-public", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeImagesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr-public", "ECR PUBLIC", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SpencerFrontendService.DescribeImages");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeImagesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeImagesOutput, body, allocator);
}
