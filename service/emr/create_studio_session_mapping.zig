const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityType = @import("identity_type.zig").IdentityType;

pub const CreateStudioSessionMappingInput = struct {
    /// The globally unique identifier (GUID) of the user or group from the IAM
    /// Identity Center
    /// Identity Store. For more information, see
    /// [UserId](https://docs.aws.amazon.com/singlesignon/latest/IdentityStoreAPIReference/API_User.html#singlesignon-Type-User-UserId) and [GroupId](https://docs.aws.amazon.com/singlesignon/latest/IdentityStoreAPIReference/API_Group.html#singlesignon-Type-Group-GroupId) in the *IAM Identity Center Identity Store API
    /// Reference*. Either `IdentityName` or `IdentityId` must
    /// be specified, but not both.
    identity_id: ?[]const u8 = null,

    /// The name of the user or group. For more information, see
    /// [UserName](https://docs.aws.amazon.com/singlesignon/latest/IdentityStoreAPIReference/API_User.html#singlesignon-Type-User-UserName) and [DisplayName](https://docs.aws.amazon.com/singlesignon/latest/IdentityStoreAPIReference/API_Group.html#singlesignon-Type-Group-DisplayName) in the *IAM Identity Center Identity Store API
    /// Reference*. Either `IdentityName` or `IdentityId` must
    /// be specified, but not both.
    identity_name: ?[]const u8 = null,

    /// Specifies whether the identity to map to the Amazon EMR Studio is a user or
    /// a
    /// group.
    identity_type: IdentityType,

    /// The Amazon Resource Name (ARN) for the session policy that will be applied
    /// to the user
    /// or group. You should specify the ARN for the session policy that you want to
    /// apply, not the
    /// ARN of your user role. For more information, see [Create an Amazon EMR
    /// Studio User Role with Session
    /// Policies](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-studio-user-role.html).
    session_policy_arn: []const u8,

    /// The ID of the Amazon EMR Studio to which the user or group will be
    /// mapped.
    studio_id: []const u8,

    pub const json_field_names = .{
        .identity_id = "IdentityId",
        .identity_name = "IdentityName",
        .identity_type = "IdentityType",
        .session_policy_arn = "SessionPolicyArn",
        .studio_id = "StudioId",
    };
};

pub const CreateStudioSessionMappingOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStudioSessionMappingInput, options: CallOptions) !CreateStudioSessionMappingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStudioSessionMappingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.CreateStudioSessionMapping");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStudioSessionMappingOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
