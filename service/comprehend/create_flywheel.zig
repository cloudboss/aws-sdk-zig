const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSecurityConfig = @import("data_security_config.zig").DataSecurityConfig;
const ModelType = @import("model_type.zig").ModelType;
const Tag = @import("tag.zig").Tag;
const TaskConfig = @import("task_config.zig").TaskConfig;

pub const CreateFlywheelInput = struct {
    /// To associate an existing model with the flywheel, specify the Amazon
    /// Resource Number (ARN) of the model version.
    /// Do not set `TaskConfig` or `ModelType` if you specify an `ActiveModelArn`.
    active_model_arn: ?[]const u8 = null,

    /// A unique identifier for the request. If you don't set the client request
    /// token, Amazon
    /// Comprehend generates one.
    client_request_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend the permissions required to access the flywheel
    /// data in the data lake.
    data_access_role_arn: []const u8,

    /// Enter the S3 location for the data lake. You can specify a new S3 bucket or
    /// a new folder of an
    /// existing S3 bucket. The flywheel creates the data lake at this location.
    data_lake_s3_uri: []const u8,

    /// Data security configurations.
    data_security_config: ?DataSecurityConfig = null,

    /// Name for the flywheel.
    flywheel_name: []const u8,

    /// The model type. You need to set `ModelType` if you are creating a flywheel
    /// for a new model.
    model_type: ?ModelType = null,

    /// The tags to associate with this flywheel.
    tags: ?[]const Tag = null,

    /// Configuration about the model associated with the flywheel.
    /// You need to set `TaskConfig` if you are creating a flywheel for a new model.
    task_config: ?TaskConfig = null,

    pub const json_field_names = .{
        .active_model_arn = "ActiveModelArn",
        .client_request_token = "ClientRequestToken",
        .data_access_role_arn = "DataAccessRoleArn",
        .data_lake_s3_uri = "DataLakeS3Uri",
        .data_security_config = "DataSecurityConfig",
        .flywheel_name = "FlywheelName",
        .model_type = "ModelType",
        .tags = "Tags",
        .task_config = "TaskConfig",
    };
};

pub const CreateFlywheelOutput = struct {
    /// The Amazon Resource Number (ARN) of the active model version.
    active_model_arn: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the flywheel.
    flywheel_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_model_arn = "ActiveModelArn",
        .flywheel_arn = "FlywheelArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFlywheelInput, options: CallOptions) !CreateFlywheelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehend", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFlywheelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehend", "Comprehend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.CreateFlywheel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFlywheelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFlywheelOutput, body, allocator);
}
