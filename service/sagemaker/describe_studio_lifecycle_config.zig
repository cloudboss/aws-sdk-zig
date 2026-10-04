const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StudioLifecycleConfigAppType = @import("studio_lifecycle_config_app_type.zig").StudioLifecycleConfigAppType;

pub const DescribeStudioLifecycleConfigInput = struct {
    /// The name of the Amazon SageMaker AI Studio Lifecycle Configuration to
    /// describe.
    studio_lifecycle_config_name: []const u8,

    pub const json_field_names = .{
        .studio_lifecycle_config_name = "StudioLifecycleConfigName",
    };
};

pub const DescribeStudioLifecycleConfigOutput = struct {
    /// The creation time of the Amazon SageMaker AI Studio Lifecycle Configuration.
    creation_time: ?i64 = null,

    /// This value is equivalent to CreationTime because Amazon SageMaker AI Studio
    /// Lifecycle Configurations are immutable.
    last_modified_time: ?i64 = null,

    /// The App type that the Lifecycle Configuration is attached to.
    studio_lifecycle_config_app_type: ?StudioLifecycleConfigAppType = null,

    /// The ARN of the Lifecycle Configuration to describe.
    studio_lifecycle_config_arn: ?[]const u8 = null,

    /// The content of your Amazon SageMaker AI Studio Lifecycle Configuration
    /// script.
    studio_lifecycle_config_content: ?[]const u8 = null,

    /// The name of the Amazon SageMaker AI Studio Lifecycle Configuration that is
    /// described.
    studio_lifecycle_config_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .studio_lifecycle_config_app_type = "StudioLifecycleConfigAppType",
        .studio_lifecycle_config_arn = "StudioLifecycleConfigArn",
        .studio_lifecycle_config_content = "StudioLifecycleConfigContent",
        .studio_lifecycle_config_name = "StudioLifecycleConfigName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeStudioLifecycleConfigInput, options: CallOptions) !DescribeStudioLifecycleConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeStudioLifecycleConfigInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeStudioLifecycleConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeStudioLifecycleConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeStudioLifecycleConfigOutput, body, allocator);
}
