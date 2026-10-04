const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalysisMethod = @import("analysis_method.zig").AnalysisMethod;
const SelectedAnalysisMethod = @import("selected_analysis_method.zig").SelectedAnalysisMethod;
const TableReference = @import("table_reference.zig").TableReference;
const ConfiguredTable = @import("configured_table.zig").ConfiguredTable;

pub const UpdateConfiguredTableInput = struct {
    /// The columns of the underlying table that can be used by collaborations or
    /// analysis rules.
    allowed_columns: ?[]const []const u8 = null,

    /// The analysis method for the configured table.
    ///
    /// `DIRECT_QUERY` allows SQL queries to be run directly on this table.
    ///
    /// `DIRECT_JOB` allows PySpark jobs to be run directly on this table.
    ///
    /// `MULTIPLE` allows both SQL queries and PySpark jobs to be run directly on
    /// this table.
    analysis_method: ?AnalysisMethod = null,

    /// The identifier for the configured table to update. Currently accepts the
    /// configured table ID.
    configured_table_identifier: []const u8,

    /// A new description for the configured table.
    description: ?[]const u8 = null,

    /// A new name for the configured table.
    name: ?[]const u8 = null,

    /// The selected analysis methods for the table configuration update.
    selected_analysis_methods: ?[]const SelectedAnalysisMethod = null,

    table_reference: ?TableReference = null,

    pub const json_field_names = .{
        .allowed_columns = "allowedColumns",
        .analysis_method = "analysisMethod",
        .configured_table_identifier = "configuredTableIdentifier",
        .description = "description",
        .name = "name",
        .selected_analysis_methods = "selectedAnalysisMethods",
        .table_reference = "tableReference",
    };
};

pub const UpdateConfiguredTableOutput = struct {
    /// The updated configured table.
    configured_table: ?ConfiguredTable = null,

    pub const json_field_names = .{
        .configured_table = "configuredTable",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConfiguredTableInput, options: CallOptions) !UpdateConfiguredTableOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConfiguredTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/configuredTables/");
    try path_buf.appendSlice(allocator, input.configured_table_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.allowed_columns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"allowedColumns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.analysis_method) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"analysisMethod\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.selected_analysis_methods) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"selectedAnalysisMethods\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.table_reference) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tableReference\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConfiguredTableOutput {
    var result: UpdateConfiguredTableOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateConfiguredTableOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
