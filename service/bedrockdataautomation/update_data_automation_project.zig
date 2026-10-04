const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomOutputConfiguration = @import("custom_output_configuration.zig").CustomOutputConfiguration;
const DataAutomationLibraryConfiguration = @import("data_automation_library_configuration.zig").DataAutomationLibraryConfiguration;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const OverrideConfiguration = @import("override_configuration.zig").OverrideConfiguration;
const DataAutomationProjectStage = @import("data_automation_project_stage.zig").DataAutomationProjectStage;
const StandardOutputConfiguration = @import("standard_output_configuration.zig").StandardOutputConfiguration;
const DataAutomationProjectStatus = @import("data_automation_project_status.zig").DataAutomationProjectStatus;

pub const UpdateDataAutomationProjectInput = struct {
    custom_output_configuration: ?CustomOutputConfiguration = null,

    data_automation_library_configuration: ?DataAutomationLibraryConfiguration = null,

    encryption_configuration: ?EncryptionConfiguration = null,

    override_configuration: ?OverrideConfiguration = null,

    /// ARN generated at the server side when a DataAutomationProject is created
    project_arn: []const u8,

    project_description: ?[]const u8 = null,

    project_stage: ?DataAutomationProjectStage = null,

    standard_output_configuration: StandardOutputConfiguration,

    pub const json_field_names = .{
        .custom_output_configuration = "customOutputConfiguration",
        .data_automation_library_configuration = "dataAutomationLibraryConfiguration",
        .encryption_configuration = "encryptionConfiguration",
        .override_configuration = "overrideConfiguration",
        .project_arn = "projectArn",
        .project_description = "projectDescription",
        .project_stage = "projectStage",
        .standard_output_configuration = "standardOutputConfiguration",
    };
};

pub const UpdateDataAutomationProjectOutput = struct {
    project_arn: []const u8,

    project_stage: ?DataAutomationProjectStage = null,

    status: ?DataAutomationProjectStatus = null,

    pub const json_field_names = .{
        .project_arn = "projectArn",
        .project_stage = "projectStage",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataAutomationProjectInput, options: CallOptions) !UpdateDataAutomationProjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDataAutomationProjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-data-automation", "Bedrock Data Automation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/data-automation-projects/");
    try path_buf.appendSlice(allocator, input.project_arn);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.custom_output_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customOutputConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.data_automation_library_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dataAutomationLibraryConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.encryption_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"encryptionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.override_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"overrideConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.project_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"projectDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.project_stage) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"projectStage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"standardOutputConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.standard_output_configuration), input.standard_output_configuration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDataAutomationProjectOutput {
    var result: UpdateDataAutomationProjectOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateDataAutomationProjectOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
