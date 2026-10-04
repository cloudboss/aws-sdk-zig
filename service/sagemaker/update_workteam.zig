const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MemberDefinition = @import("member_definition.zig").MemberDefinition;
const NotificationConfiguration = @import("notification_configuration.zig").NotificationConfiguration;
const WorkerAccessConfiguration = @import("worker_access_configuration.zig").WorkerAccessConfiguration;
const Workteam = @import("workteam.zig").Workteam;

pub const UpdateWorkteamInput = struct {
    /// An updated description for the work team.
    description: ?[]const u8 = null,

    /// A list of `MemberDefinition` objects that contains objects that identify the
    /// workers that make up the work team.
    ///
    /// Workforces can be created using Amazon Cognito or your own OIDC Identity
    /// Provider (IdP). For private workforces created using Amazon Cognito use
    /// `CognitoMemberDefinition`. For workforces created using your own OIDC
    /// identity provider (IdP) use `OidcMemberDefinition`. You should not provide
    /// input for both of these parameters in a single request.
    ///
    /// For workforces created using Amazon Cognito, private work teams correspond
    /// to Amazon Cognito *user groups* within the user pool used to create a
    /// workforce. All of the `CognitoMemberDefinition` objects that make up the
    /// member definition must have the same `ClientId` and `UserPool` values. To
    /// add a Amazon Cognito user group to an existing worker pool, see Adding
    /// groups to a User Pool. For more information about user pools, see [Amazon
    /// Cognito User
    /// Pools](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools.html).
    ///
    /// For workforces created using your own OIDC IdP, specify the user groups that
    /// you want to include in your private work team in `OidcMemberDefinition` by
    /// listing those groups in `Groups`. Be aware that user groups that are already
    /// in the work team must also be listed in `Groups` when you make this request
    /// to remain on the work team. If you do not include these user groups, they
    /// will no longer be associated with the work team you update.
    member_definitions: ?[]const MemberDefinition = null,

    /// Configures SNS topic notifications for available or expiring work items
    notification_configuration: ?NotificationConfiguration = null,

    /// Use this optional parameter to constrain access to an Amazon S3 resource
    /// based on the IP address using supported IAM global condition keys. The
    /// Amazon S3 resource is accessed in the worker portal using a Amazon S3
    /// presigned URL.
    worker_access_configuration: ?WorkerAccessConfiguration = null,

    /// The name of the work team to update.
    workteam_name: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .member_definitions = "MemberDefinitions",
        .notification_configuration = "NotificationConfiguration",
        .worker_access_configuration = "WorkerAccessConfiguration",
        .workteam_name = "WorkteamName",
    };
};

pub const UpdateWorkteamOutput = struct {
    /// A `Workteam` object that describes the updated work team.
    workteam: ?Workteam = null,

    pub const json_field_names = .{
        .workteam = "Workteam",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkteamInput, options: CallOptions) !UpdateWorkteamOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkteamInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateWorkteam");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkteamOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateWorkteamOutput, body, allocator);
}
