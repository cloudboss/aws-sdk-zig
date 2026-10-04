const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskTemplateConstraints = @import("task_template_constraints.zig").TaskTemplateConstraints;
const TaskTemplateDefaults = @import("task_template_defaults.zig").TaskTemplateDefaults;
const TaskTemplateField = @import("task_template_field.zig").TaskTemplateField;
const TaskTemplateStatus = @import("task_template_status.zig").TaskTemplateStatus;

pub const UpdateTaskTemplateInput = struct {
    /// Constraints that are applicable to the fields listed.
    /// Although this parameter is marked as optional in the API model, the service
    /// requires it when calling `CreateTaskTemplate` or `UpdateTaskTemplate`.
    /// The `RequiredFields` array must contain at least one element, and the field
    /// of type `NAME` must be included in `RequiredFields`.
    constraints: ?TaskTemplateConstraints = null,

    /// The identifier of the flow that runs by default when a task is created by
    /// referencing this template.
    ///
    /// Although this parameter is marked as optional, the request must contain
    /// either a `ContactFlowId` or a field of type `QUICK_CONNECT`.
    contact_flow_id: ?[]const u8 = null,

    /// The default values for fields when a task is created by referencing this
    /// template.
    defaults: ?TaskTemplateDefaults = null,

    /// The description of the task template.
    description: ?[]const u8 = null,

    /// Fields that are part of the template.
    ///
    /// The request must contain exactly one field of type `NAME`. This field must
    /// also be listed in the `RequiredFields` array within the `Constraints`
    /// parameter.
    fields: ?[]const TaskTemplateField = null,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The name of the task template.
    name: ?[]const u8 = null,

    /// The ContactFlowId for the flow that will be run if this template is used to
    /// create a self-assigned task.
    self_assign_flow_id: ?[]const u8 = null,

    /// Marks a template as `ACTIVE` or `INACTIVE` for a task to refer to it.
    /// Tasks can only be created from `ACTIVE` templates.
    /// If a template is marked as `INACTIVE`, then a task that refers to this
    /// template cannot be created.
    ///
    /// Although this parameter is marked as optional, the service requires it when
    /// calling `UpdateTaskTemplate`.
    status: ?TaskTemplateStatus = null,

    /// A unique identifier for the task template.
    task_template_id: []const u8,

    pub const json_field_names = .{
        .constraints = "Constraints",
        .contact_flow_id = "ContactFlowId",
        .defaults = "Defaults",
        .description = "Description",
        .fields = "Fields",
        .instance_id = "InstanceId",
        .name = "Name",
        .self_assign_flow_id = "SelfAssignFlowId",
        .status = "Status",
        .task_template_id = "TaskTemplateId",
    };
};

pub const UpdateTaskTemplateOutput = struct {
    /// The Amazon Resource Name (ARN) for the task template resource.
    arn: ?[]const u8 = null,

    /// Constraints that are applicable to the fields listed.
    /// Although this parameter is marked as optional in the API model, the service
    /// requires it when calling `CreateTaskTemplate` or `UpdateTaskTemplate`.
    /// The `RequiredFields` array must contain at least one element, and the field
    /// of type `NAME` must be included in `RequiredFields`.
    constraints: ?TaskTemplateConstraints = null,

    /// The identifier of the flow that runs by default when a task is created by
    /// referencing this template.
    contact_flow_id: ?[]const u8 = null,

    /// The timestamp when the task template was created.
    created_time: ?i64 = null,

    /// The default values for fields when a task is created by referencing this
    /// template.
    defaults: ?TaskTemplateDefaults = null,

    /// The description of the task template.
    description: ?[]const u8 = null,

    /// Fields that are part of the template.
    fields: ?[]const TaskTemplateField = null,

    /// The identifier of the task template resource.
    id: ?[]const u8 = null,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: ?[]const u8 = null,

    /// The timestamp when the task template was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the task template.
    name: ?[]const u8 = null,

    /// The ContactFlowId for the flow that will be run if this template is used to
    /// create a self-assigned task.
    self_assign_flow_id: ?[]const u8 = null,

    /// Marks a template as `ACTIVE` or `INACTIVE` for a task to refer to it.
    /// Tasks can only be created from `ACTIVE` templates.
    /// If a template is marked as `INACTIVE`, then a task that refers to this
    /// template cannot be created.
    status: ?TaskTemplateStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .constraints = "Constraints",
        .contact_flow_id = "ContactFlowId",
        .created_time = "CreatedTime",
        .defaults = "Defaults",
        .description = "Description",
        .fields = "Fields",
        .id = "Id",
        .instance_id = "InstanceId",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .self_assign_flow_id = "SelfAssignFlowId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTaskTemplateInput, options: CallOptions) !UpdateTaskTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTaskTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/instance/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/task/template/");
    try path_buf.appendSlice(allocator, input.task_template_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.constraints) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Constraints\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.contact_flow_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ContactFlowId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.defaults) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Defaults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.fields) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Fields\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.self_assign_flow_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SelfAssignFlowId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Status\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTaskTemplateOutput {
    const result: UpdateTaskTemplateOutput = try aws.json.parseJsonObject(
        UpdateTaskTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
