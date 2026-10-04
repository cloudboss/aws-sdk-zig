const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceCount = @import("resource_count.zig").ResourceCount;

pub const GetDiscoveredResourceCountsInput = struct {
    /// The maximum number of ResourceCount objects
    /// returned on each page. The default is 100. You cannot specify a
    /// number greater than 100. If you specify 0, Config uses the
    /// default.
    limit: ?i32 = null,

    /// The `nextToken` string returned on a previous page
    /// that you use to get the next page of results in a paginated
    /// response.
    next_token: ?[]const u8 = null,

    /// The comma-separated list that specifies the resource types that
    /// you want Config to return (for example,
    /// `"AWS::EC2::Instance"`,
    /// `"AWS::IAM::User"`).
    ///
    /// If a value for `resourceTypes` is not specified, Config returns all resource
    /// types that Config is recording in
    /// the region for your account.
    ///
    /// If the configuration recorder is turned off, Config
    /// returns an empty list of ResourceCount
    /// objects. If the configuration recorder is not recording a
    /// specific resource type (for example, S3 buckets), that resource
    /// type is not returned in the list of ResourceCount objects.
    resource_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .limit = "limit",
        .next_token = "nextToken",
        .resource_types = "resourceTypes",
    };
};

pub const GetDiscoveredResourceCountsOutput = struct {
    /// The string that you use in a subsequent request to get the next
    /// page of results in a paginated response.
    next_token: ?[]const u8 = null,

    /// The list of `ResourceCount` objects. Each object is
    /// listed in descending order by the number of resources.
    resource_counts: ?[]const ResourceCount = null,

    /// The total number of resources that Config is recording in
    /// the region for your account. If you specify resource types in the
    /// request, Config returns only the total number of resources for
    /// those resource types.
    ///
    /// **Example**
    ///
    /// * Config is recording three resource types in the US
    /// East (Ohio) Region for your account: 25 EC2 instances, 20
    /// IAM users, and 15 S3 buckets, for a total of 60
    /// resources.
    ///
    /// * You make a call to the
    /// `GetDiscoveredResourceCounts` action and
    /// specify the resource type,
    /// `"AWS::EC2::Instances"`, in the
    /// request.
    ///
    /// * Config returns 25 for
    /// `totalDiscoveredResources`.
    total_discovered_resources: ?i64 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .resource_counts = "resourceCounts",
        .total_discovered_resources = "totalDiscoveredResources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDiscoveredResourceCountsInput, options: CallOptions) !GetDiscoveredResourceCountsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDiscoveredResourceCountsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.GetDiscoveredResourceCounts");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDiscoveredResourceCountsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDiscoveredResourceCountsOutput, body, allocator);
}
