const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CreateExperimentTemplateActionInput = @import("create_experiment_template_action_input.zig").CreateExperimentTemplateActionInput;
const CreateExperimentTemplateExperimentOptionsInput = @import("create_experiment_template_experiment_options_input.zig").CreateExperimentTemplateExperimentOptionsInput;
const CreateExperimentTemplateReportConfigurationInput = @import("create_experiment_template_report_configuration_input.zig").CreateExperimentTemplateReportConfigurationInput;
const CreateExperimentTemplateLogConfigurationInput = @import("create_experiment_template_log_configuration_input.zig").CreateExperimentTemplateLogConfigurationInput;
const CreateExperimentTemplateStopConditionInput = @import("create_experiment_template_stop_condition_input.zig").CreateExperimentTemplateStopConditionInput;
const CreateExperimentTemplateTargetInput = @import("create_experiment_template_target_input.zig").CreateExperimentTemplateTargetInput;
const ExperimentTemplate = @import("experiment_template.zig").ExperimentTemplate;

pub const CreateExperimentTemplateInput = struct {
    /// The actions for the experiment.
    actions: []const aws.map.MapEntry(CreateExperimentTemplateActionInput),

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request.
    client_token: []const u8,

    /// A description for the experiment template.
    description: []const u8,

    /// The experiment options for the experiment template.
    experiment_options: ?CreateExperimentTemplateExperimentOptionsInput = null,

    /// The experiment report configuration for the experiment template.
    experiment_report_configuration: ?CreateExperimentTemplateReportConfigurationInput = null,

    /// The configuration for experiment logging.
    log_configuration: ?CreateExperimentTemplateLogConfigurationInput = null,

    /// The Amazon Resource Name (ARN) of an IAM role that grants the FIS service
    /// permission to perform service actions on your behalf.
    role_arn: []const u8,

    /// The stop conditions.
    stop_conditions: []const CreateExperimentTemplateStopConditionInput,

    /// The tags to apply to the experiment template.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The targets for the experiment.
    targets: ?[]const aws.map.MapEntry(CreateExperimentTemplateTargetInput) = null,

    pub const json_field_names = .{
        .actions = "actions",
        .client_token = "clientToken",
        .description = "description",
        .experiment_options = "experimentOptions",
        .experiment_report_configuration = "experimentReportConfiguration",
        .log_configuration = "logConfiguration",
        .role_arn = "roleArn",
        .stop_conditions = "stopConditions",
        .tags = "tags",
        .targets = "targets",
    };
};

pub const CreateExperimentTemplateOutput = struct {
    /// Information about the experiment template.
    experiment_template: ?ExperimentTemplate = null,

    pub const json_field_names = .{
        .experiment_template = "experimentTemplate",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateExperimentTemplateInput, options: Options) !CreateExperimentTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "fis");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateExperimentTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fis", "fis", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/experimentTemplates";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"actions\":");
    try aws.json.writeValue(@TypeOf(input.actions), input.actions, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, alloc, &body_buf);
    has_prev = true;
    if (input.experiment_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"experimentOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.experiment_report_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"experimentReportConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.log_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"logConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"stopConditions\":");
    try aws.json.writeValue(@TypeOf(input.stop_conditions), input.stop_conditions, alloc, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.targets) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"targets\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateExperimentTemplateOutput {
    var result: CreateExperimentTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateExperimentTemplateOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
