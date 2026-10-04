const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApprovalStrategyResponse = @import("approval_strategy_response.zig").ApprovalStrategyResponse;
const GetApprovalTeamResponseApprover = @import("get_approval_team_response_approver.zig").GetApprovalTeamResponseApprover;
const PendingUpdate = @import("pending_update.zig").PendingUpdate;
const PolicyReference = @import("policy_reference.zig").PolicyReference;
const ApprovalTeamStatus = @import("approval_team_status.zig").ApprovalTeamStatus;
const ApprovalTeamStatusCode = @import("approval_team_status_code.zig").ApprovalTeamStatusCode;

pub const GetApprovalTeamInput = struct {
    /// Amazon Resource Name (ARN) for the team.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub const GetApprovalTeamOutput = struct {
    /// An `ApprovalStrategyResponse` object. Contains details for how the team
    /// grants approval.
    approval_strategy: ?ApprovalStrategyResponse = null,

    /// An array of `GetApprovalTeamResponseApprover ` objects. Contains details for
    /// the approvers in the team.
    approvers: ?[]const GetApprovalTeamResponseApprover = null,

    /// Amazon Resource Name (ARN) for the team.
    arn: ?[]const u8 = null,

    /// Timestamp when the team was created.
    creation_time: ?i64 = null,

    /// Description for the team.
    description: ?[]const u8 = null,

    /// Timestamp when the team was last updated.
    last_update_time: ?i64 = null,

    /// Name of the approval team.
    name: ?[]const u8 = null,

    /// Total number of approvers in the team.
    number_of_approvers: ?i32 = null,

    /// A `PendingUpdate` object. Contains details for the pending updates for the
    /// team, if applicable.
    pending_update: ?PendingUpdate = null,

    /// An array of `PolicyReference` objects. Contains a list of policies that
    /// define the permissions for team resources.
    policies: ?[]const PolicyReference = null,

    /// Status for the team. For more information, see [Team
    /// health](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-health.html) in
    /// the *Multi-party approval User Guide*.
    status: ?ApprovalTeamStatus = null,

    /// Status code for the approval team. For more information, see [Team
    /// health](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-health.html) in
    /// the *Multi-party approval User Guide*.
    status_code: ?ApprovalTeamStatusCode = null,

    /// Message describing the status for the team.
    status_message: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) for the session.
    update_session_arn: ?[]const u8 = null,

    /// Version ID for the team.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .approval_strategy = "ApprovalStrategy",
        .approvers = "Approvers",
        .arn = "Arn",
        .creation_time = "CreationTime",
        .description = "Description",
        .last_update_time = "LastUpdateTime",
        .name = "Name",
        .number_of_approvers = "NumberOfApprovers",
        .pending_update = "PendingUpdate",
        .policies = "Policies",
        .status = "Status",
        .status_code = "StatusCode",
        .status_message = "StatusMessage",
        .update_session_arn = "UpdateSessionArn",
        .version_id = "VersionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApprovalTeamInput, options: CallOptions) !GetApprovalTeamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mpa", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetApprovalTeamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mpa", "MPA", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/approval-teams/");
    try path_buf.appendSlice(allocator, input.arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetApprovalTeamOutput {
    const result: GetApprovalTeamOutput = try aws.json.parseJsonObject(
        GetApprovalTeamOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
