const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FsxProtocol = @import("fsx_protocol.zig").FsxProtocol;

pub const DescribeLocationFsxOpenZfsInput = struct {
    /// The Amazon Resource Name (ARN) of the FSx for OpenZFS location to describe.
    location_arn: []const u8,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
    };
};

pub const DescribeLocationFsxOpenZfsOutput = struct {
    /// The time that the FSx for OpenZFS location was created.
    creation_time: ?i64 = null,

    /// The ARN of the FSx for OpenZFS location that was described.
    location_arn: ?[]const u8 = null,

    /// The uniform resource identifier (URI) of the FSx for OpenZFS location that
    /// was
    /// described.
    ///
    /// Example: `fsxz://us-west-2.fs-1234567890abcdef02/fsx/folderA/folder`
    location_uri: ?[]const u8 = null,

    /// The type of protocol that DataSync uses to access your file system.
    protocol: ?FsxProtocol = null,

    /// The ARNs of the security groups that are configured for the FSx for OpenZFS
    /// file
    /// system.
    security_group_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .location_arn = "LocationArn",
        .location_uri = "LocationUri",
        .protocol = "Protocol",
        .security_group_arns = "SecurityGroupArns",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLocationFsxOpenZfsInput, options: CallOptions) !DescribeLocationFsxOpenZfsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLocationFsxOpenZfsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.DescribeLocationFsxOpenZfs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLocationFsxOpenZfsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLocationFsxOpenZfsOutput, body, allocator);
}
