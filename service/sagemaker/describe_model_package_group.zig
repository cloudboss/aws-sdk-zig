const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserContext = @import("user_context.zig").UserContext;
const ManagedConfiguration = @import("managed_configuration.zig").ManagedConfiguration;
const ModelPackageGroupStatus = @import("model_package_group_status.zig").ModelPackageGroupStatus;

pub const DescribeModelPackageGroupInput = struct {
    /// The name of the model group to describe.
    model_package_group_name: []const u8,

    pub const json_field_names = .{
        .model_package_group_name = "ModelPackageGroupName",
    };
};

pub const DescribeModelPackageGroupOutput = struct {
    created_by: ?UserContext = null,

    /// The time that the model group was created.
    creation_time: i64,

    /// The managed configuration of the model package group.
    managed_configuration: ?ManagedConfiguration = null,

    /// The Amazon Resource Name (ARN) of the model group.
    model_package_group_arn: []const u8,

    /// A description of the model group.
    model_package_group_description: ?[]const u8 = null,

    /// The name of the model group.
    model_package_group_name: []const u8,

    /// The status of the model group.
    model_package_group_status: ModelPackageGroupStatus,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .managed_configuration = "ManagedConfiguration",
        .model_package_group_arn = "ModelPackageGroupArn",
        .model_package_group_description = "ModelPackageGroupDescription",
        .model_package_group_name = "ModelPackageGroupName",
        .model_package_group_status = "ModelPackageGroupStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeModelPackageGroupInput, options: CallOptions) !DescribeModelPackageGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeModelPackageGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeModelPackageGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeModelPackageGroupOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeModelPackageGroupOutput, body, allocator);
}
