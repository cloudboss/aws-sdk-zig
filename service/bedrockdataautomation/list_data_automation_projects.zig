const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BlueprintFilter = @import("blueprint_filter.zig").BlueprintFilter;
const DataAutomationLibraryFilter = @import("data_automation_library_filter.zig").DataAutomationLibraryFilter;
const DataAutomationProjectStageFilter = @import("data_automation_project_stage_filter.zig").DataAutomationProjectStageFilter;
const ResourceOwner = @import("resource_owner.zig").ResourceOwner;
const DataAutomationProjectSummary = @import("data_automation_project_summary.zig").DataAutomationProjectSummary;

pub const ListDataAutomationProjectsInput = struct {
    blueprint_filter: ?BlueprintFilter = null,

    library_filter: ?DataAutomationLibraryFilter = null,

    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    project_stage_filter: ?DataAutomationProjectStageFilter = null,

    resource_owner: ?ResourceOwner = null,

    pub const json_field_names = .{
        .blueprint_filter = "blueprintFilter",
        .library_filter = "libraryFilter",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .project_stage_filter = "projectStageFilter",
        .resource_owner = "resourceOwner",
    };
};

pub const ListDataAutomationProjectsOutput = struct {
    next_token: ?[]const u8 = null,

    projects: ?[]const DataAutomationProjectSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .projects = "projects",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDataAutomationProjectsInput, options: CallOptions) !ListDataAutomationProjectsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDataAutomationProjectsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-data-automation", "Bedrock Data Automation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/data-automation-projects/";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.blueprint_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"blueprintFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.library_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"libraryFilter\":");
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
    if (input.project_stage_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"projectStageFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_owner) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceOwner\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDataAutomationProjectsOutput {
    var result: ListDataAutomationProjectsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListDataAutomationProjectsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
