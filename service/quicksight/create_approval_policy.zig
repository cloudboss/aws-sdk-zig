const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GovernedAction = @import("governed_action.zig").GovernedAction;
const ApplicableTo = @import("applicable_to.zig").ApplicableTo;
const AssetType = @import("asset_type.zig").AssetType;
const ApprovalPolicy = @import("approval_policy.zig").ApprovalPolicy;

pub const CreateApprovalPolicyInput = struct {
    /// The list of governed actions that trigger the approval workflow.
    actions: []const GovernedAction,

    /// The scoping configuration that determines who the approval policy applies
    /// to.
    applicable_to: ApplicableTo,

    /// The list of group ARNs whose members can approve requests.
    approval_groups: []const []const u8,

    /// The list of asset types that the approval policy applies to.
    asset_types: []const AssetType,

    /// A description of the approval policy.
    description: ?[]const u8 = null,

    /// The name of the approval policy.
    name: []const u8,

    /// The unique identifier to assign to the approval policy. You cannot change
    /// this value after you create the policy.
    policy_id: []const u8,

    pub const json_field_names = .{
        .actions = "Actions",
        .applicable_to = "ApplicableTo",
        .approval_groups = "ApprovalGroups",
        .asset_types = "AssetTypes",
        .description = "Description",
        .name = "Name",
        .policy_id = "PolicyId",
    };
};

pub const CreateApprovalPolicyOutput = struct {
    /// The approval policy that was created.
    policy: ?ApprovalPolicy = null,

    pub const json_field_names = .{
        .policy = "Policy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApprovalPolicyInput, options: CallOptions) !CreateApprovalPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApprovalPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/governance/approvalworkflows/policies";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Actions\":");
    try aws.json.writeValue(@TypeOf(input.actions), input.actions, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ApplicableTo\":");
    try aws.json.writeValue(@TypeOf(input.applicable_to), input.applicable_to, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ApprovalGroups\":");
    try aws.json.writeValue(@TypeOf(input.approval_groups), input.approval_groups, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AssetTypes\":");
    try aws.json.writeValue(@TypeOf(input.asset_types), input.asset_types, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PolicyId\":");
    try aws.json.writeValue(@TypeOf(input.policy_id), input.policy_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApprovalPolicyOutput {
    const result: CreateApprovalPolicyOutput = try aws.json.parseJsonObject(
        CreateApprovalPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
