const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateType = @import("update_type.zig").UpdateType;
const UpdateInfoEntry = @import("update_info_entry.zig").UpdateInfoEntry;

pub const DescribeUpdateDirectoryInput = struct {
    /// The unique identifier of the directory.
    directory_id: []const u8,

    /// The `DescribeUpdateDirectoryResult`. NextToken value from a previous call to
    /// DescribeUpdateDirectory. Pass null if this is the first call.
    next_token: ?[]const u8 = null,

    /// The name of the Region.
    region_name: ?[]const u8 = null,

    /// The type of updates you want to describe for the directory.
    update_type: UpdateType,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .next_token = "NextToken",
        .region_name = "RegionName",
        .update_type = "UpdateType",
    };
};

pub const DescribeUpdateDirectoryOutput = struct {
    /// If not null, more results are available. Pass this value for the `NextToken`
    /// parameter.
    next_token: ?[]const u8 = null,

    /// The list of update activities on a directory for the requested update type.
    update_activities: ?[]const UpdateInfoEntry = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .update_activities = "UpdateActivities",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeUpdateDirectoryInput, options: CallOptions) !DescribeUpdateDirectoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeUpdateDirectoryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.DescribeUpdateDirectory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeUpdateDirectoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeUpdateDirectoryOutput, body, allocator);
}
