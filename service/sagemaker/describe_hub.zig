const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HubStatus = @import("hub_status.zig").HubStatus;
const HubS3StorageConfig = @import("hub_s3_storage_config.zig").HubS3StorageConfig;

pub const DescribeHubInput = struct {
    /// The name of the hub to describe.
    hub_name: []const u8,

    pub const json_field_names = .{
        .hub_name = "HubName",
    };
};

pub const DescribeHubOutput = struct {
    /// The date and time that the hub was created.
    creation_time: i64,

    /// The failure reason if importing hub content failed.
    failure_reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the hub.
    hub_arn: []const u8,

    /// A description of the hub.
    hub_description: ?[]const u8 = null,

    /// The display name of the hub.
    hub_display_name: ?[]const u8 = null,

    /// The name of the hub.
    hub_name: []const u8,

    /// The searchable keywords for the hub.
    hub_search_keywords: ?[]const []const u8 = null,

    /// The status of the hub.
    hub_status: HubStatus,

    /// The date and time that the hub was last modified.
    last_modified_time: i64,

    /// The Amazon S3 storage configuration for the hub.
    s3_storage_config: ?HubS3StorageConfig = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .hub_arn = "HubArn",
        .hub_description = "HubDescription",
        .hub_display_name = "HubDisplayName",
        .hub_name = "HubName",
        .hub_search_keywords = "HubSearchKeywords",
        .hub_status = "HubStatus",
        .last_modified_time = "LastModifiedTime",
        .s3_storage_config = "S3StorageConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeHubInput, options: CallOptions) !DescribeHubOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeHubInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeHub");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeHubOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeHubOutput, body, allocator);
}
