const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const UpdateExperimentTemplateActionInputItem = @import("update_experiment_template_action_input_item.zig").UpdateExperimentTemplateActionInputItem;
const UpdateExperimentTemplateExperimentOptionsInput = @import("update_experiment_template_experiment_options_input.zig").UpdateExperimentTemplateExperimentOptionsInput;
const UpdateExperimentTemplateReportConfigurationInput = @import("update_experiment_template_report_configuration_input.zig").UpdateExperimentTemplateReportConfigurationInput;
const UpdateExperimentTemplateLogConfigurationInput = @import("update_experiment_template_log_configuration_input.zig").UpdateExperimentTemplateLogConfigurationInput;
const UpdateExperimentTemplateStopConditionInput = @import("update_experiment_template_stop_condition_input.zig").UpdateExperimentTemplateStopConditionInput;
const UpdateExperimentTemplateTargetInput = @import("update_experiment_template_target_input.zig").UpdateExperimentTemplateTargetInput;
const ExperimentTemplate = @import("experiment_template.zig").ExperimentTemplate;

pub const UpdateExperimentTemplateInput = struct {
    /// The actions for the experiment.
    actions: ?[]const aws.map.MapEntry(UpdateExperimentTemplateActionInputItem) = null,

    /// A description for the template.
    description: ?[]const u8 = null,

    /// The experiment options for the experiment template.
    experiment_options: ?UpdateExperimentTemplateExperimentOptionsInput = null,

    /// The experiment report configuration for the experiment template.
    experiment_report_configuration: ?UpdateExperimentTemplateReportConfigurationInput = null,

    /// The ID of the experiment template.
    id: []const u8,

    /// The configuration for experiment logging.
    log_configuration: ?UpdateExperimentTemplateLogConfigurationInput = null,

    /// The Amazon Resource Name (ARN) of an IAM role that grants the FIS service
    /// permission to perform service actions on your behalf.
    role_arn: ?[]const u8 = null,

    /// The stop conditions for the experiment.
    stop_conditions: ?[]const UpdateExperimentTemplateStopConditionInput = null,

    /// The targets for the experiment.
    targets: ?[]const aws.map.MapEntry(UpdateExperimentTemplateTargetInput) = null,

    pub const json_field_names = .{
        .actions = "actions",
        .description = "description",
        .experiment_options = "experimentOptions",
        .experiment_report_configuration = "experimentReportConfiguration",
        .id = "id",
        .log_configuration = "logConfiguration",
        .role_arn = "roleArn",
        .stop_conditions = "stopConditions",
        .targets = "targets",
    };
};

pub const UpdateExperimentTemplateOutput = struct {
    /// Information about the experiment template.
    experiment_template: ?ExperimentTemplate = null,

    pub const json_field_names = .{
        .experiment_template = "experimentTemplate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateExperimentTemplateInput, options: CallOptions) !UpdateExperimentTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "fis");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateExperimentTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fis", "fis", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/experimentTemplates/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.actions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"actions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.experiment_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"experimentOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.experiment_report_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"experimentReportConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.log_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"logConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stop_conditions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stopConditions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.targets) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"targets\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateExperimentTemplateOutput {
    var result: UpdateExperimentTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateExperimentTemplateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
