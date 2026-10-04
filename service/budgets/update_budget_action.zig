const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionThreshold = @import("action_threshold.zig").ActionThreshold;
const ApprovalModel = @import("approval_model.zig").ApprovalModel;
const Definition = @import("definition.zig").Definition;
const NotificationType = @import("notification_type.zig").NotificationType;
const Subscriber = @import("subscriber.zig").Subscriber;
const Action = @import("action.zig").Action;

pub const UpdateBudgetActionInput = struct {
    account_id: []const u8,

    /// A system-generated universally unique identifier (UUID) for the action.
    action_id: []const u8,

    action_threshold: ?ActionThreshold = null,

    /// This specifies if the action needs manual or automatic approval.
    approval_model: ?ApprovalModel = null,

    budget_name: []const u8,

    definition: ?Definition = null,

    /// The role passed for action execution and reversion. Roles and actions must
    /// be in the same account.
    execution_role_arn: ?[]const u8 = null,

    notification_type: ?NotificationType = null,

    subscribers: ?[]const Subscriber = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .action_id = "ActionId",
        .action_threshold = "ActionThreshold",
        .approval_model = "ApprovalModel",
        .budget_name = "BudgetName",
        .definition = "Definition",
        .execution_role_arn = "ExecutionRoleArn",
        .notification_type = "NotificationType",
        .subscribers = "Subscribers",
    };
};

pub const UpdateBudgetActionOutput = struct {
    account_id: []const u8,

    budget_name: []const u8,

    /// The updated action resource information.
    new_action: ?Action = null,

    /// The previous action resource information.
    old_action: ?Action = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .budget_name = "BudgetName",
        .new_action = "NewAction",
        .old_action = "OldAction",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBudgetActionInput, options: CallOptions) !UpdateBudgetActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "budgets", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBudgetActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("budgets", "Budgets", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSBudgetServiceGateway.UpdateBudgetAction");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBudgetActionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateBudgetActionOutput, body, allocator);
}
