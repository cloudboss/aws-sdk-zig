const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResponseBudgetAction = @import("response_budget_action.zig").ResponseBudgetAction;
const BudgetSchedule = @import("budget_schedule.zig").BudgetSchedule;
const BudgetStatus = @import("budget_status.zig").BudgetStatus;
const ConsumedUsages = @import("consumed_usages.zig").ConsumedUsages;
const UsageTrackingResource = @import("usage_tracking_resource.zig").UsageTrackingResource;

pub const GetBudgetInput = struct {
    /// The budget ID.
    budget_id: []const u8,

    /// The farm ID of the farm connected to the budget.
    farm_id: []const u8,

    pub const json_field_names = .{
        .budget_id = "budgetId",
        .farm_id = "farmId",
    };
};

pub const GetBudgetOutput = struct {
    /// The budget actions for the budget.
    actions: ?[]const ResponseBudgetAction = null,

    /// The consumed usage limit for the budget.
    approximate_dollar_limit: f32,

    /// The budget ID.
    budget_id: []const u8,

    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The description of the budget.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    description: ?[]const u8 = null,

    /// The display name of the budget.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    display_name: []const u8,

    /// The date and time the queue stopped.
    queue_stopped_at: ?i64 = null,

    /// The budget schedule.
    schedule: ?BudgetSchedule = null,

    /// The status of the budget.
    ///
    /// * `ACTIVE`–Get a budget being evaluated.
    /// * `INACTIVE`–Get an inactive budget. This can include expired, canceled, or
    ///   deleted statuses.
    status: BudgetStatus,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    /// The usages of the budget.
    usages: ?ConsumedUsages = null,

    /// The resource that the budget is tracking usage for.
    usage_tracking_resource: ?UsageTrackingResource = null,

    pub const json_field_names = .{
        .actions = "actions",
        .approximate_dollar_limit = "approximateDollarLimit",
        .budget_id = "budgetId",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .display_name = "displayName",
        .queue_stopped_at = "queueStoppedAt",
        .schedule = "schedule",
        .status = "status",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .usages = "usages",
        .usage_tracking_resource = "usageTrackingResource",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBudgetInput, options: CallOptions) !GetBudgetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "deadline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBudgetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2023-10-12/farms/");
    try path_buf.appendSlice(allocator, input.farm_id);
    try path_buf.appendSlice(allocator, "/budgets/");
    try path_buf.appendSlice(allocator, input.budget_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBudgetOutput {
    const result: GetBudgetOutput = try aws.json.parseJsonObject(
        GetBudgetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
