const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LimitsPerLabelSet = @import("limits_per_label_set.zig").LimitsPerLabelSet;
const WorkspaceConfigurationStatus = @import("workspace_configuration_status.zig").WorkspaceConfigurationStatus;

pub const UpdateWorkspaceConfigurationInput = struct {
    /// You can include a token in your operation to make it an idempotent
    /// opeartion.
    client_token: ?[]const u8 = null,

    /// This is an array of structures, where each structure defines a label set for
    /// the workspace, and defines the active time series limit for each of those
    /// label sets. Each label name in a label set must be unique.
    limits_per_label_set: ?[]const LimitsPerLabelSet = null,

    /// Specifies the time window in seconds for accepting out of order samples. Out
    /// of order samples older than this window are rejected.
    out_of_order_time_window_in_seconds: ?i32 = null,

    /// Specifies how many days that metrics will be retained in the workspace.
    retention_period_in_days: ?i32 = null,

    /// Specifies the duration in seconds to offset rule evaluation queries into the
    /// past. This allows ingested samples to be available before rule evaluation.
    rule_query_offset_in_seconds: ?i32 = null,

    /// The ID of the workspace that you want to update. To find the IDs of your
    /// workspaces, use the
    /// [ListWorkspaces](https://docs.aws.amazon.com/prometheus/latest/APIReference/API_ListWorkspaces.htm) operation.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .limits_per_label_set = "limitsPerLabelSet",
        .out_of_order_time_window_in_seconds = "outOfOrderTimeWindowInSeconds",
        .retention_period_in_days = "retentionPeriodInDays",
        .rule_query_offset_in_seconds = "ruleQueryOffsetInSeconds",
        .workspace_id = "workspaceId",
    };
};

pub const UpdateWorkspaceConfigurationOutput = struct {
    /// The status of the workspace configuration.
    status: ?WorkspaceConfigurationStatus = null,

    pub const json_field_names = .{
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkspaceConfigurationInput, options: CallOptions) !UpdateWorkspaceConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkspaceConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aps", "amp", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/configuration");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.limits_per_label_set) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"limitsPerLabelSet\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.out_of_order_time_window_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"outOfOrderTimeWindowInSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.retention_period_in_days) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"retentionPeriodInDays\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.rule_query_offset_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ruleQueryOffsetInSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkspaceConfigurationOutput {
    const result: UpdateWorkspaceConfigurationOutput = try aws.json.parseJsonObject(
        UpdateWorkspaceConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
