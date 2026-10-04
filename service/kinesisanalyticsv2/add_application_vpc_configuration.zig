const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;
const VpcConfigurationDescription = @import("vpc_configuration_description.zig").VpcConfigurationDescription;

pub const AddApplicationVpcConfigurationInput = struct {
    /// The name of an existing application.
    application_name: []const u8,

    /// A value you use to implement strong concurrency for application updates. You
    /// must
    /// provide the `ApplicationVersionID` or the `ConditionalToken`. You get
    /// the application's current `ConditionalToken` using DescribeApplication. For
    /// better concurrency support, use the
    /// `ConditionalToken` parameter instead of
    /// `CurrentApplicationVersionId`.
    conditional_token: ?[]const u8 = null,

    /// The version of the application to which you want to add the VPC
    /// configuration. You must
    /// provide the `CurrentApplicationVersionId` or the `ConditionalToken`. You
    /// can use the DescribeApplication operation to get the current application
    /// version. If the version specified is not the current version, the
    /// `ConcurrentModificationException` is returned. For better concurrency
    /// support,
    /// use the `ConditionalToken` parameter instead of
    /// `CurrentApplicationVersionId`.
    current_application_version_id: ?i64 = null,

    /// Description of the VPC to add to the application.
    vpc_configuration: VpcConfiguration,

    pub const json_field_names = .{
        .application_name = "ApplicationName",
        .conditional_token = "ConditionalToken",
        .current_application_version_id = "CurrentApplicationVersionId",
        .vpc_configuration = "VpcConfiguration",
    };
};

pub const AddApplicationVpcConfigurationOutput = struct {
    /// The ARN of the application.
    application_arn: ?[]const u8 = null,

    /// Provides the current application version. Managed Service for Apache Flink
    /// updates the ApplicationVersionId each
    /// time you update the application.
    application_version_id: ?i64 = null,

    /// The operation ID that can be used to track the request.
    operation_id: ?[]const u8 = null,

    /// The parameters of the new VPC configuration.
    vpc_configuration_description: ?VpcConfigurationDescription = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationARN",
        .application_version_id = "ApplicationVersionId",
        .operation_id = "OperationId",
        .vpc_configuration_description = "VpcConfigurationDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddApplicationVpcConfigurationInput, options: CallOptions) !AddApplicationVpcConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisanalytics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddApplicationVpcConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisanalytics", "Kinesis Analytics V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20180523.AddApplicationVpcConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddApplicationVpcConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AddApplicationVpcConfigurationOutput, body, allocator);
}
