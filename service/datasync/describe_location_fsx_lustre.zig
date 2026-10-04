const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeLocationFsxLustreInput = struct {
    /// The Amazon Resource Name (ARN) of the FSx for Lustre location to describe.
    location_arn: []const u8,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
    };
};

pub const DescribeLocationFsxLustreOutput = struct {
    /// The time that the FSx for Lustre location was created.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the FSx for Lustre location that was
    /// described.
    location_arn: ?[]const u8 = null,

    /// The URI of the FSx for Lustre location that was described.
    location_uri: ?[]const u8 = null,

    /// The Amazon Resource Names (ARNs) of the security groups that are configured
    /// for the
    /// FSx for Lustre file system.
    security_group_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .location_arn = "LocationArn",
        .location_uri = "LocationUri",
        .security_group_arns = "SecurityGroupArns",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLocationFsxLustreInput, options: CallOptions) !DescribeLocationFsxLustreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datasync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLocationFsxLustreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.DescribeLocationFsxLustre");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLocationFsxLustreOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLocationFsxLustreOutput, body, allocator);
}
