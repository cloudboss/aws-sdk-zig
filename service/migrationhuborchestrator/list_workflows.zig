const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MigrationWorkflowStatusEnum = @import("migration_workflow_status_enum.zig").MigrationWorkflowStatusEnum;
const MigrationWorkflowSummary = @import("migration_workflow_summary.zig").MigrationWorkflowSummary;

pub const ListWorkflowsInput = struct {
    /// The name of the application configured in Application Discovery Service.
    ads_application_configuration_name: ?[]const u8 = null,

    /// The maximum number of results that can be returned.
    max_results: ?i32 = null,

    /// The name of the migration workflow.
    name: ?[]const u8 = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// The status of the migration workflow.
    status: ?MigrationWorkflowStatusEnum = null,

    /// The ID of the template.
    template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ads_application_configuration_name = "adsApplicationConfigurationName",
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
        .status = "status",
        .template_id = "templateId",
    };
};

pub const ListWorkflowsOutput = struct {
    /// The summary of the migration workflow.
    migration_workflow_summary: ?[]const MigrationWorkflowSummary = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .migration_workflow_summary = "migrationWorkflowSummary",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWorkflowsInput, options: CallOptions) !ListWorkflowsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "migrationhub-orchestrator", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWorkflowsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-orchestrator", "MigrationHubOrchestrator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/migrationworkflows";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.ads_application_configuration_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "adsApplicationConfigurationName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "name=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.template_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "templateId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWorkflowsOutput {
    var result: ListWorkflowsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListWorkflowsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
