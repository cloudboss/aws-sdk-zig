const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeploymentPatternVersionFilter = @import("deployment_pattern_version_filter.zig").DeploymentPatternVersionFilter;
const DeploymentPatternVersionDataSummary = @import("deployment_pattern_version_data_summary.zig").DeploymentPatternVersionDataSummary;

pub const ListDeploymentPatternVersionsInput = struct {
    /// The name of the deployment pattern. You can use the [
    /// `ListWorkloadDeploymentPatterns`
    /// ](https://docs.aws.amazon.com/launchwizard/latest/APIReference/API_ListWorkloadDeploymentPatterns.html) operation to discover supported values for this parameter.
    deployment_pattern_name: []const u8,

    /// Filters to apply when listing deployment pattern versions.
    filters: ?[]const DeploymentPatternVersionFilter = null,

    /// The maximum number of deployment pattern versions to list.
    max_results: ?i32 = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    /// The name of the workload. You can use the [ `ListWorkloads`
    /// ](https://docs.aws.amazon.com/launchwizard/latest/APIReference/API_ListWorkloads.html) operation to discover supported values for this parameter.
    workload_name: []const u8,

    pub const json_field_names = .{
        .deployment_pattern_name = "deploymentPatternName",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .workload_name = "workloadName",
    };
};

pub const ListDeploymentPatternVersionsOutput = struct {
    /// The deployment pattern versions.
    deployment_pattern_versions: ?[]const DeploymentPatternVersionDataSummary = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployment_pattern_versions = "deploymentPatternVersions",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDeploymentPatternVersionsInput, options: CallOptions) !ListDeploymentPatternVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "launchwizard", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDeploymentPatternVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("launchwizard", "Launch Wizard", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/listDeploymentPatternVersions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"deploymentPatternName\":");
    try aws.json.writeValue(@TypeOf(input.deployment_pattern_name), input.deployment_pattern_name, allocator, &body_buf);
    has_prev = true;
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"workloadName\":");
    try aws.json.writeValue(@TypeOf(input.workload_name), input.workload_name, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDeploymentPatternVersionsOutput {
    var result: ListDeploymentPatternVersionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListDeploymentPatternVersionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
