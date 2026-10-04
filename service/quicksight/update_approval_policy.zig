const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GovernedAction = @import("governed_action.zig").GovernedAction;
const ApplicableTo = @import("applicable_to.zig").ApplicableTo;
const AssetType = @import("asset_type.zig").AssetType;
const ApprovalPolicy = @import("approval_policy.zig").ApprovalPolicy;

pub const UpdateApprovalPolicyInput = struct {
    /// The list of governed actions that trigger the approval workflow.
    actions: ?[]const GovernedAction = null,

    /// The scoping configuration that determines who the approval policy applies
    /// to.
    applicable_to: ?ApplicableTo = null,

    /// The list of group ARNs whose members can approve requests.
    approval_groups: ?[]const []const u8 = null,

    /// The list of asset types that the approval policy applies to.
    asset_types: ?[]const AssetType = null,

    /// A description of the approval policy.
    description: ?[]const u8 = null,

    /// The name of the approval policy.
    name: ?[]const u8 = null,

    /// The unique identifier of the approval policy to update.
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

pub const UpdateApprovalPolicyOutput = struct {
    /// The updated approval policy.
    policy: ?ApprovalPolicy = null,

    pub const json_field_names = .{
        .policy = "Policy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApprovalPolicyInput, options: CallOptions) !UpdateApprovalPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateApprovalPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/governance/approvalworkflows/policies/");
    try path_buf.appendSlice(allocator, input.policy_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.actions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Actions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.applicable_to) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ApplicableTo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.approval_groups) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ApprovalGroups\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.asset_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AssetTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateApprovalPolicyOutput {
    const result: UpdateApprovalPolicyOutput = try aws.json.parseJsonObject(
        UpdateApprovalPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
