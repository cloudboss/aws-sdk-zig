const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegionStatus = @import("region_status.zig").RegionStatus;

pub const DescribeRegionInput = struct {
    /// The Amazon Resource Name (ARN) of the IAM Identity Center instance.
    instance_arn: []const u8,

    /// The name of the Amazon Web Services Region to retrieve information about.
    /// The Region name must be 1-32 characters long and follow the pattern of
    /// Amazon Web Services Region names (for example, us-east-1).
    region_name: []const u8,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
        .region_name = "RegionName",
    };
};

pub const DescribeRegionOutput = struct {
    /// The timestamp when the Region was added to the IAM Identity Center instance.
    /// For the primary Region, this is the IAM Identity Center instance creation
    /// time.
    added_date: ?i64 = null,

    /// Indicates whether this is the primary Region where the IAM Identity Center
    /// instance was originally enabled. For more information on the difference
    /// between the primary Region and additional Regions, see [IAM Identity Center
    /// User
    /// Guide](https://docs.aws.amazon.com/singlesignon/latest/userguide/multi-region-iam-identity-center.html)
    is_primary_region: ?bool = null,

    /// The Amazon Web Services Region name.
    region_name: ?[]const u8 = null,

    /// The current status of the Region. Valid values are ACTIVE (Region is
    /// operational), ADDING (Region replication workflow is in progress), or
    /// REMOVING (Region removal workflow is in progress).
    status: ?RegionStatus = null,

    pub const json_field_names = .{
        .added_date = "AddedDate",
        .is_primary_region = "IsPrimaryRegion",
        .region_name = "RegionName",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRegionInput, options: CallOptions) !DescribeRegionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sso", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRegionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sso", "SSO Admin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.DescribeRegion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRegionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeRegionOutput, body, allocator);
}
