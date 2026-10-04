const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PrivacyConfiguration = @import("privacy_configuration.zig").PrivacyConfiguration;

pub const GetCollaborationConfiguredModelAlgorithmAssociationInput = struct {
    /// The collaboration ID for the collaboration that contains the configured
    /// model algorithm association that you want to return information about.
    collaboration_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the configured model algorithm association
    /// that you want to return information about.
    configured_model_algorithm_association_arn: []const u8,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .configured_model_algorithm_association_arn = "configuredModelAlgorithmAssociationArn",
    };
};

pub const GetCollaborationConfiguredModelAlgorithmAssociationOutput = struct {
    /// The collaboration ID of the collaboration that contains the configured model
    /// algorithm association.
    collaboration_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the configured model algorithm
    /// association.
    configured_model_algorithm_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the configured model algorithm
    /// association.
    configured_model_algorithm_association_arn: []const u8,

    /// The time at which the configured model algorithm association was created.
    create_time: i64,

    /// The account ID of the member that created the configured model algorithm
    /// association.
    creator_account_id: []const u8,

    /// The description of the configured model algorithm association.
    description: ?[]const u8 = null,

    /// The membership ID of the member that created the configured model algorithm
    /// association.
    membership_identifier: []const u8,

    /// The name of the configured model algorithm association.
    name: []const u8,

    privacy_configuration: ?PrivacyConfiguration = null,

    /// The most recent time at which the configured model algorithm association was
    /// updated.
    update_time: i64,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .configured_model_algorithm_arn = "configuredModelAlgorithmArn",
        .configured_model_algorithm_association_arn = "configuredModelAlgorithmAssociationArn",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
        .description = "description",
        .membership_identifier = "membershipIdentifier",
        .name = "name",
        .privacy_configuration = "privacyConfiguration",
        .update_time = "updateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCollaborationConfiguredModelAlgorithmAssociationInput, options: CallOptions) !GetCollaborationConfiguredModelAlgorithmAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms-ml", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCollaborationConfiguredModelAlgorithmAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/collaborations/");
    try path_buf.appendSlice(allocator, input.collaboration_identifier);
    try path_buf.appendSlice(allocator, "/configured-model-algorithm-associations/");
    try path_buf.appendSlice(allocator, input.configured_model_algorithm_association_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCollaborationConfiguredModelAlgorithmAssociationOutput {
    var result: GetCollaborationConfiguredModelAlgorithmAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCollaborationConfiguredModelAlgorithmAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
