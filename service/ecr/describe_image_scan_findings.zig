const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageIdentifier = @import("image_identifier.zig").ImageIdentifier;
const ImageScanFindings = @import("image_scan_findings.zig").ImageScanFindings;
const ImageScanStatus = @import("image_scan_status.zig").ImageScanStatus;

pub const DescribeImageScanFindingsInput = struct {
    image_id: ImageIdentifier,

    /// The maximum number of image scan results returned by
    /// `DescribeImageScanFindings` in paginated output. When this parameter is
    /// used, `DescribeImageScanFindings` only returns `maxResults`
    /// results in a single page along with a `nextToken` response element. The
    /// remaining results of the initial request can be seen by sending another
    /// `DescribeImageScanFindings` request with the returned
    /// `nextToken` value. This value can be between 1 and 1000. If this
    /// parameter is not used, then `DescribeImageScanFindings` returns up to 100
    /// results and a `nextToken` value, if applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `DescribeImageScanFindings` request where `maxResults` was
    /// used and the results exceeded the value of that parameter. Pagination
    /// continues from the
    /// end of the previous results that returned the `nextToken` value. This value
    /// is null when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// The Amazon Web Services account ID associated with the registry that
    /// contains the repository in
    /// which to describe the image scan findings for. If you do not specify a
    /// registry, the default registry is assumed.
    registry_id: ?[]const u8 = null,

    /// The repository for the image for which to describe the scan findings.
    repository_name: []const u8,

    pub const json_field_names = .{
        .image_id = "imageId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub const DescribeImageScanFindingsOutput = struct {
    image_id: ?ImageIdentifier = null,

    /// The information contained in the image scan findings.
    image_scan_findings: ?ImageScanFindings = null,

    /// The current state of the scan.
    image_scan_status: ?ImageScanStatus = null,

    /// The `nextToken` value to include in a future
    /// `DescribeImageScanFindings` request. When the results of a
    /// `DescribeImageScanFindings` request exceed `maxResults`, this
    /// value can be used to retrieve the next page of results. This value is null
    /// when there
    /// are no more results to return.
    next_token: ?[]const u8 = null,

    /// The registry ID associated with the request.
    registry_id: ?[]const u8 = null,

    /// The repository name associated with the request.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_id = "imageId",
        .image_scan_findings = "imageScanFindings",
        .image_scan_status = "imageScanStatus",
        .next_token = "nextToken",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeImageScanFindingsInput, options: CallOptions) !DescribeImageScanFindingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeImageScanFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr", "ECR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.DescribeImageScanFindings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeImageScanFindingsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeImageScanFindingsOutput, body, allocator);
}
