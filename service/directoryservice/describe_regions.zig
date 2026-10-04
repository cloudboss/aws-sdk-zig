const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegionDescription = @import("region_description.zig").RegionDescription;

pub const DescribeRegionsInput = struct {
    /// The identifier of the directory.
    directory_id: []const u8,

    /// The `DescribeRegionsResult.NextToken` value from a previous call to
    /// DescribeRegions. Pass null if this is the first call.
    next_token: ?[]const u8 = null,

    /// The name of the Region. For example, `us-east-1`.
    region_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .next_token = "NextToken",
        .region_name = "RegionName",
    };
};

pub const DescribeRegionsOutput = struct {
    /// If not null, more results are available. Pass this value for the `NextToken`
    /// parameter in a subsequent call to DescribeRegions to retrieve the next set
    /// of items.
    next_token: ?[]const u8 = null,

    /// List of Region information related to the directory for each replicated
    /// Region.
    regions_description: ?[]const RegionDescription = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .regions_description = "RegionsDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRegionsInput, options: CallOptions) !DescribeRegionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRegionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.DescribeRegions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRegionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeRegionsOutput, body, allocator);
}
