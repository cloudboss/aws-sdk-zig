const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityUnitsConfiguration = @import("capacity_units_configuration.zig").CapacityUnitsConfiguration;
const DocumentMetadataConfiguration = @import("document_metadata_configuration.zig").DocumentMetadataConfiguration;
const UserContextPolicy = @import("user_context_policy.zig").UserContextPolicy;
const UserGroupResolutionConfiguration = @import("user_group_resolution_configuration.zig").UserGroupResolutionConfiguration;
const UserTokenConfiguration = @import("user_token_configuration.zig").UserTokenConfiguration;

pub const UpdateIndexInput = struct {
    /// Sets the number of additional document storage and query capacity units that
    /// should be
    /// used by the index. You can change the capacity of the index up to 5 times
    /// per day, or make 5
    /// API calls.
    ///
    /// If you are using extra storage units, you can't reduce the storage capacity
    /// below what is
    /// required to meet the storage needs for your index.
    capacity_units: ?CapacityUnitsConfiguration = null,

    /// A new description for the index.
    description: ?[]const u8 = null,

    /// The document metadata configuration you want to update for the index.
    /// Document metadata
    /// are fields or attributes associated with your documents. For example, the
    /// company department
    /// name associated with each document.
    document_metadata_configuration_updates: ?[]const DocumentMetadataConfiguration = null,

    /// The identifier of the index you want to update.
    id: []const u8,

    /// A new name for the index.
    name: ?[]const u8 = null,

    /// An Identity and Access Management (IAM) role that gives Amazon Kendra
    /// permission to access Amazon CloudWatch logs and metrics.
    role_arn: ?[]const u8 = null,

    /// The user context policy.
    ///
    /// If you're using an Amazon Kendra Gen AI Enterprise Edition index, you can
    /// only use
    /// `ATTRIBUTE_FILTER` to filter search results by user context. If you're
    /// using an Amazon Kendra Gen AI Enterprise Edition index and you try to use
    /// `USER_TOKEN` to configure user context policy, Amazon Kendra returns a
    /// `ValidationException` error.
    user_context_policy: ?UserContextPolicy = null,

    /// Gets users and groups from IAM Identity Center identity source. To configure
    /// this,
    /// see
    /// [UserGroupResolutionConfiguration](https://docs.aws.amazon.com/kendra/latest/dg/API_UserGroupResolutionConfiguration.html). This is useful for user context filtering,
    /// where search results are filtered based on the user or their group access to
    /// documents.
    ///
    /// If you're using an Amazon Kendra Gen AI Enterprise Edition index,
    /// `UserGroupResolutionConfiguration` isn't supported.
    user_group_resolution_configuration: ?UserGroupResolutionConfiguration = null,

    /// The user token configuration.
    ///
    /// If you're using an Amazon Kendra Gen AI Enterprise Edition index and you try
    /// to use
    /// `UserTokenConfigurations` to configure user context policy, Amazon Kendra
    /// returns
    /// a `ValidationException` error.
    user_token_configurations: ?[]const UserTokenConfiguration = null,

    pub const json_field_names = .{
        .capacity_units = "CapacityUnits",
        .description = "Description",
        .document_metadata_configuration_updates = "DocumentMetadataConfigurationUpdates",
        .id = "Id",
        .name = "Name",
        .role_arn = "RoleArn",
        .user_context_policy = "UserContextPolicy",
        .user_group_resolution_configuration = "UserGroupResolutionConfiguration",
        .user_token_configurations = "UserTokenConfigurations",
    };
};

pub const UpdateIndexOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIndexInput, options: CallOptions) !UpdateIndexOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.UpdateIndex");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIndexOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
