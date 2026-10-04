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
const DataAutomationProjectType = @import("data_automation_project_type.zig").DataAutomationProjectType;
const StandardOutputConfiguration = @import("standard_output_configuration.zig").StandardOutputConfiguration;
const Tag = @import("tag.zig").Tag;
const DataAutomationProjectStatus = @import("data_automation_project_status.zig").DataAutomationProjectStatus;

pub const CreateDataAutomationProjectInput = struct {
    client_token: ?[]const u8 = null,

    custom_output_configuration: ?CustomOutputConfiguration = null,

    data_automation_library_configuration: ?DataAutomationLibraryConfiguration = null,

    encryption_configuration: ?EncryptionConfiguration = null,

    override_configuration: ?OverrideConfiguration = null,

    project_description: ?[]const u8 = null,

    project_name: []const u8,

    project_stage: ?DataAutomationProjectStage = null,

    project_type: ?DataAutomationProjectType = null,

    standard_output_configuration: StandardOutputConfiguration,

    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .custom_output_configuration = "customOutputConfiguration",
        .data_automation_library_configuration = "dataAutomationLibraryConfiguration",
        .encryption_configuration = "encryptionConfiguration",
        .override_configuration = "overrideConfiguration",
        .project_description = "projectDescription",
        .project_name = "projectName",
        .project_stage = "projectStage",
        .project_type = "projectType",
        .standard_output_configuration = "standardOutputConfiguration",
        .tags = "tags",
    };
};

pub const CreateDataAutomationProjectOutput = struct {
    project_arn: []const u8,

    project_stage: ?DataAutomationProjectStage = null,

    status: ?DataAutomationProjectStatus = null,

    pub const json_field_names = .{
        .project_arn = "projectArn",
        .project_stage = "projectStage",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataAutomationProjectInput, options: CallOptions) !CreateDataAutomationProjectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataAutomationProjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-data-automation", "Bedrock Data Automation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/data-automation-projects/";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"projectName\":");
    try aws.json.writeValue(@TypeOf(input.project_name), input.project_name, allocator, &body_buf);
    has_prev = true;
    if (input.project_stage) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"projectStage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.project_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"projectType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"standardOutputConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.standard_output_configuration), input.standard_output_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataAutomationProjectOutput {
    const result: CreateDataAutomationProjectOutput = try aws.json.parseJsonObject(
        CreateDataAutomationProjectOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
