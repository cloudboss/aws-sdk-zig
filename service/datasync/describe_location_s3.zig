const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3Config = @import("s3_config.zig").S3Config;
const S3StorageClass = @import("s3_storage_class.zig").S3StorageClass;

pub const DescribeLocationS3Input = struct {
    /// Specifies the Amazon Resource Name (ARN) of the Amazon S3 location.
    location_arn: []const u8,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
    };
};

pub const DescribeLocationS3Output = struct {
    /// The ARNs of the DataSync agents deployed on your Outpost when using working
    /// with
    /// Amazon S3 on Outposts.
    ///
    /// For more information, see [Deploy your DataSync agent
    /// on
    /// Outposts](https://docs.aws.amazon.com/datasync/latest/userguide/deploy-agents.html#outposts-agent).
    agent_arns: ?[]const []const u8 = null,

    /// The time that the Amazon S3 location was created.
    creation_time: ?i64 = null,

    /// The ARN of the Amazon S3 location.
    location_arn: ?[]const u8 = null,

    /// The URL of the Amazon S3 location that was described.
    location_uri: ?[]const u8 = null,

    s3_config: ?S3Config = null,

    /// When Amazon S3 is a destination location, this is the storage class that you
    /// chose
    /// for your objects.
    ///
    /// Some storage classes have behaviors that can affect your Amazon S3 storage
    /// costs.
    /// For more information, see [Storage class
    /// considerations with Amazon S3
    /// transfers](https://docs.aws.amazon.com/datasync/latest/userguide/create-s3-location.html#using-storage-classes).
    s3_storage_class: ?S3StorageClass = null,

    pub const json_field_names = .{
        .agent_arns = "AgentArns",
        .creation_time = "CreationTime",
        .location_arn = "LocationArn",
        .location_uri = "LocationUri",
        .s3_config = "S3Config",
        .s3_storage_class = "S3StorageClass",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLocationS3Input, options: CallOptions) !DescribeLocationS3Output {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLocationS3Input, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.DescribeLocationS3");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLocationS3Output {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLocationS3Output, body, allocator);
}
