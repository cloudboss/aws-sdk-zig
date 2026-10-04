const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Action = @import("action.zig").Action;
const EventBatchingCondition = @import("event_batching_condition.zig").EventBatchingCondition;
const Predicate = @import("predicate.zig").Predicate;
const TriggerType = @import("trigger_type.zig").TriggerType;

pub const CreateTriggerInput = struct {
    /// The actions initiated by this trigger when it fires.
    actions: []const Action,

    /// A description of the new trigger.
    description: ?[]const u8 = null,

    /// Batch condition that must be met (specified number of events received or
    /// batch time window expired)
    /// before EventBridge event trigger fires.
    event_batching_condition: ?EventBatchingCondition = null,

    /// The name of the trigger.
    name: []const u8,

    /// A predicate to specify when the new trigger should fire.
    ///
    /// This field is required when the trigger type is `CONDITIONAL`.
    predicate: ?Predicate = null,

    /// A `cron` expression used to specify the schedule (see [Time-Based Schedules
    /// for Jobs and
    /// Crawlers](https://docs.aws.amazon.com/glue/latest/dg/monitor-data-warehouse-schedule.html). For example, to run
    /// something every day at 12:15 UTC, you would specify:
    /// `cron(15 12 * * ? *)`.
    ///
    /// This field is required when the trigger type is SCHEDULED.
    schedule: ?[]const u8 = null,

    /// Set to `true` to start `SCHEDULED` and `CONDITIONAL`
    /// triggers when created. True is not supported for `ON_DEMAND` triggers.
    start_on_creation: ?bool = null,

    /// The tags to use with this trigger. You may use tags to limit access to the
    /// trigger.
    /// For more information about tags in Glue, see
    /// [Amazon Web Services Tags in
    /// Glue](https://docs.aws.amazon.com/glue/latest/dg/monitor-tags.html) in the
    /// developer guide.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the new trigger.
    @"type": TriggerType,

    /// The name of the workflow associated with the trigger.
    workflow_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .description = "Description",
        .event_batching_condition = "EventBatchingCondition",
        .name = "Name",
        .predicate = "Predicate",
        .schedule = "Schedule",
        .start_on_creation = "StartOnCreation",
        .tags = "Tags",
        .@"type" = "Type",
        .workflow_name = "WorkflowName",
    };
};

pub const CreateTriggerOutput = struct {
    /// The name of the trigger.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTriggerInput, options: CallOptions) !CreateTriggerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTriggerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateTrigger");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTriggerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateTriggerOutput, body, allocator);
}
