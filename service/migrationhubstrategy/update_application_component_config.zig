const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppType = @import("app_type.zig").AppType;
const InclusionStatus = @import("inclusion_status.zig").InclusionStatus;
const SourceCode = @import("source_code.zig").SourceCode;
const StrategyOption = @import("strategy_option.zig").StrategyOption;

pub const UpdateApplicationComponentConfigInput = struct {
    /// The ID of the application component. The ID is unique within an AWS account.
    application_component_id: []const u8,

    /// The type of known component.
    app_type: ?AppType = null,

    /// Update the configuration request of an application component. If it is set
    /// to true, the
    /// source code and/or database credentials are updated. If it is set to false,
    /// the source code
    /// and/or database credentials are updated and an analysis is initiated.
    configure_only: ?bool = null,

    /// Indicates whether the application component has been included for server
    /// recommendation
    /// or not.
    inclusion_status: ?InclusionStatus = null,

    /// Database credentials.
    secrets_manager_key: ?[]const u8 = null,

    /// The list of source code configurations to update for the application
    /// component.
    source_code_list: ?[]const SourceCode = null,

    /// The preferred strategy options for the application component. Use values
    /// from the GetApplicationComponentStrategies response.
    strategy_option: ?StrategyOption = null,

    pub const json_field_names = .{
        .application_component_id = "applicationComponentId",
        .app_type = "appType",
        .configure_only = "configureOnly",
        .inclusion_status = "inclusionStatus",
        .secrets_manager_key = "secretsManagerKey",
        .source_code_list = "sourceCodeList",
        .strategy_option = "strategyOption",
    };
};

pub const UpdateApplicationComponentConfigOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApplicationComponentConfigInput, options: CallOptions) !UpdateApplicationComponentConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsmigrationhubstrategyrecommendation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateApplicationComponentConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-strategy", "MigrationHubStrategy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/update-applicationcomponent-config/";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"applicationComponentId\":");
    try aws.json.writeValue(@TypeOf(input.application_component_id), input.application_component_id, allocator, &body_buf);
    has_prev = true;
    if (input.app_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"appType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.configure_only) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"configureOnly\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.inclusion_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inclusionStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.secrets_manager_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"secretsManagerKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_code_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sourceCodeList\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.strategy_option) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"strategyOption\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateApplicationComponentConfigOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateApplicationComponentConfigOutput = .{};

    return result;
}
