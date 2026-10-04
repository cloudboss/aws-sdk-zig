const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionThreshold = @import("action_threshold.zig").ActionThreshold;
const ActionType = @import("action_type.zig").ActionType;
const ApprovalModel = @import("approval_model.zig").ApprovalModel;
const Definition = @import("definition.zig").Definition;
const NotificationType = @import("notification_type.zig").NotificationType;
const ResourceTag = @import("resource_tag.zig").ResourceTag;
const Subscriber = @import("subscriber.zig").Subscriber;

pub const CreateBudgetActionInput = struct {
    account_id: []const u8,

    action_threshold: ActionThreshold,

    /// The type of action. This defines the type of tasks that can be carried out
    /// by this action. This field also determines the format for definition.
    action_type: ActionType,

    /// This specifies if the action needs manual or automatic approval.
    approval_model: ApprovalModel,

    budget_name: []const u8,

    definition: Definition,

    /// The role passed for action execution and reversion. Roles and actions must
    /// be in the same account.
    execution_role_arn: []const u8,

    notification_type: NotificationType,

    /// An optional list of tags to associate with the specified budget action. Each
    /// tag consists of a
    /// key and a value, and each key must be unique for the resource.
    resource_tags: ?[]const ResourceTag = null,

    subscribers: []const Subscriber,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .action_threshold = "ActionThreshold",
        .action_type = "ActionType",
        .approval_model = "ApprovalModel",
        .budget_name = "BudgetName",
        .definition = "Definition",
        .execution_role_arn = "ExecutionRoleArn",
        .notification_type = "NotificationType",
        .resource_tags = "ResourceTags",
        .subscribers = "Subscribers",
    };
};

pub const CreateBudgetActionOutput = struct {
    account_id: []const u8,

    /// A system-generated universally unique identifier (UUID) for the action.
    action_id: []const u8,

    budget_name: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .action_id = "ActionId",
        .budget_name = "BudgetName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBudgetActionInput, options: CallOptions) !CreateBudgetActionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBudgetActionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBudgetServiceGateway.CreateBudgetAction");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBudgetActionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateBudgetActionOutput, body, allocator);
}
