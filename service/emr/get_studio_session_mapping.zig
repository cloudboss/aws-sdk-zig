const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityType = @import("identity_type.zig").IdentityType;
const SessionMappingDetail = @import("session_mapping_detail.zig").SessionMappingDetail;

pub const GetStudioSessionMappingInput = struct {
    /// The globally unique identifier (GUID) of the user or group. For more
    /// information, see
    /// [UserId](https://docs.aws.amazon.com/singlesignon/latest/IdentityStoreAPIReference/API_User.html#singlesignon-Type-User-UserId) and [GroupId](https://docs.aws.amazon.com/singlesignon/latest/IdentityStoreAPIReference/API_Group.html#singlesignon-Type-Group-GroupId) in the *IAM Identity Center Identity Store API
    /// Reference*. Either `IdentityName` or `IdentityId` must
    /// be specified.
    identity_id: ?[]const u8 = null,

    /// The name of the user or group to fetch. For more information, see
    /// [UserName](https://docs.aws.amazon.com/singlesignon/latest/IdentityStoreAPIReference/API_User.html#singlesignon-Type-User-UserName) and [DisplayName](https://docs.aws.amazon.com/singlesignon/latest/IdentityStoreAPIReference/API_Group.html#singlesignon-Type-Group-DisplayName) in the *IAM Identity Center Identity Store API
    /// Reference*. Either `IdentityName` or `IdentityId` must
    /// be specified.
    identity_name: ?[]const u8 = null,

    /// Specifies whether the identity to fetch is a user or a group.
    identity_type: IdentityType,

    /// The ID of the Amazon EMR Studio.
    studio_id: []const u8,

    pub const json_field_names = .{
        .identity_id = "IdentityId",
        .identity_name = "IdentityName",
        .identity_type = "IdentityType",
        .studio_id = "StudioId",
    };
};

pub const GetStudioSessionMappingOutput = struct {
    /// The session mapping details for the specified Amazon EMR Studio and
    /// identity,
    /// including session policy ARN and creation time.
    session_mapping: ?SessionMappingDetail = null,

    pub const json_field_names = .{
        .session_mapping = "SessionMapping",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetStudioSessionMappingInput, options: CallOptions) !GetStudioSessionMappingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetStudioSessionMappingInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.GetStudioSessionMapping");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetStudioSessionMappingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetStudioSessionMappingOutput, body, allocator);
}
