const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppAssessmentScheduleType = @import("app_assessment_schedule_type.zig").AppAssessmentScheduleType;
const EventSubscription = @import("event_subscription.zig").EventSubscription;
const PermissionModel = @import("permission_model.zig").PermissionModel;
const App = @import("app.zig").App;

pub const UpdateAppInput = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: []const u8,

    /// Assessment execution schedule with 'Daily' or 'Disabled' values.
    assessment_schedule: ?AppAssessmentScheduleType = null,

    /// Specifies if the resiliency policy ARN should be cleared.
    clear_resiliency_policy_arn: ?bool = null,

    /// The optional description for an app.
    description: ?[]const u8 = null,

    /// The list of events you would like to subscribe and get notification for.
    /// Currently,
    /// Resilience Hub supports notifications only for **Drift
    /// detected** and **Scheduled assessment failure**
    /// events.
    event_subscriptions: ?[]const EventSubscription = null,

    /// Defines the roles and credentials that Resilience Hub would use while
    /// creating an
    /// application, importing its resources, and running an assessment.
    permission_model: ?PermissionModel = null,

    /// Amazon Resource Name (ARN) of the resiliency policy. The format for this ARN
    /// is:
    /// arn:`partition`:resiliencehub:`region`:`account`:resiliency-policy/`policy-id`. For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    policy_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .assessment_schedule = "assessmentSchedule",
        .clear_resiliency_policy_arn = "clearResiliencyPolicyArn",
        .description = "description",
        .event_subscriptions = "eventSubscriptions",
        .permission_model = "permissionModel",
        .policy_arn = "policyArn",
    };
};

pub const UpdateAppOutput = struct {
    /// The specified application, returned as an object with details including
    /// compliance status,
    /// creation time, description, resiliency score, and more.
    app: ?App = null,

    pub const json_field_names = .{
        .app = "app",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAppInput, options: CallOptions) !UpdateAppOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/update-app";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appArn\":");
    try aws.json.writeValue(@TypeOf(input.app_arn), input.app_arn, allocator, &body_buf);
    has_prev = true;
    if (input.assessment_schedule) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assessmentSchedule\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.clear_resiliency_policy_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clearResiliencyPolicyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.event_subscriptions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"eventSubscriptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.permission_model) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"permissionModel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.policy_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAppOutput {
    var result: UpdateAppOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAppOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
