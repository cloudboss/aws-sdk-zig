const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppType = @import("app_type.zig").AppType;
const ResourceSpec = @import("resource_spec.zig").ResourceSpec;
const Tag = @import("tag.zig").Tag;

pub const CreateAppInput = struct {
    /// The name of the app.
    app_name: []const u8,

    /// The type of app.
    app_type: AppType,

    /// The domain ID.
    domain_id: []const u8,

    /// Indicates whether the application is launched in recovery mode.
    recovery_mode: ?bool = null,

    /// The instance type and the Amazon Resource Name (ARN) of the SageMaker AI
    /// image created on the instance.
    ///
    /// The value of `InstanceType` passed as part of the `ResourceSpec` in the
    /// `CreateApp` call overrides the value passed as part of the `ResourceSpec`
    /// configured for the user profile or the domain. If `InstanceType` is not
    /// specified in any of those three `ResourceSpec` values for a `KernelGateway`
    /// app, the `CreateApp` call fails with a request validation error.
    resource_spec: ?ResourceSpec = null,

    /// The name of the space. If this value is not set, then `UserProfileName` must
    /// be set.
    space_name: ?[]const u8 = null,

    /// Each tag consists of a key and an optional value. Tag keys must be unique
    /// per resource.
    tags: ?[]const Tag = null,

    /// The user profile name. If this value is not set, then `SpaceName` must be
    /// set.
    user_profile_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_name = "AppName",
        .app_type = "AppType",
        .domain_id = "DomainId",
        .recovery_mode = "RecoveryMode",
        .resource_spec = "ResourceSpec",
        .space_name = "SpaceName",
        .tags = "Tags",
        .user_profile_name = "UserProfileName",
    };
};

pub const CreateAppOutput = struct {
    /// The Amazon Resource Name (ARN) of the app.
    app_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_arn = "AppArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAppInput, options: CallOptions) !CreateAppOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAppInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateApp");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAppOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAppOutput, body, allocator);
}
