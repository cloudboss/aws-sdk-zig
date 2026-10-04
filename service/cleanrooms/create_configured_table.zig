const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalysisMethod = @import("analysis_method.zig").AnalysisMethod;
const SelectedAnalysisMethod = @import("selected_analysis_method.zig").SelectedAnalysisMethod;
const TableReference = @import("table_reference.zig").TableReference;
const ConfiguredTable = @import("configured_table.zig").ConfiguredTable;

pub const CreateConfiguredTableInput = struct {
    /// The columns of the underlying table that can be used by collaborations or
    /// analysis rules.
    allowed_columns: []const []const u8,

    /// The analysis method allowed for the configured tables.
    ///
    /// `DIRECT_QUERY` allows SQL queries to be run directly on this table.
    ///
    /// `DIRECT_JOB` allows PySpark jobs to be run directly on this table.
    ///
    /// `MULTIPLE` allows both SQL queries and PySpark jobs to be run directly on
    /// this table.
    analysis_method: AnalysisMethod,

    /// A description for the configured table.
    description: ?[]const u8 = null,

    /// The name of the configured table.
    name: []const u8,

    /// The analysis methods to enable for the configured table. When configured,
    /// you must specify at least two analysis methods.
    selected_analysis_methods: ?[]const SelectedAnalysisMethod = null,

    /// A reference to the table being configured.
    table_reference: TableReference,

    /// An optional label that you can assign to a resource when you create it. Each
    /// tag consists of a key and an optional value, both of which you define. When
    /// you use tagging, you can also use tag-based access control in IAM policies
    /// to control access to this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .allowed_columns = "allowedColumns",
        .analysis_method = "analysisMethod",
        .description = "description",
        .name = "name",
        .selected_analysis_methods = "selectedAnalysisMethods",
        .table_reference = "tableReference",
        .tags = "tags",
    };
};

pub const CreateConfiguredTableOutput = struct {
    /// The created configured table.
    configured_table: ?ConfiguredTable = null,

    pub const json_field_names = .{
        .configured_table = "configuredTable",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConfiguredTableInput, options: CallOptions) !CreateConfiguredTableOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConfiguredTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configuredTables";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"allowedColumns\":");
    try aws.json.writeValue(@TypeOf(input.allowed_columns), input.allowed_columns, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"analysisMethod\":");
    try aws.json.writeValue(@TypeOf(input.analysis_method), input.analysis_method, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.selected_analysis_methods) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"selectedAnalysisMethods\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"tableReference\":");
    try aws.json.writeValue(@TypeOf(input.table_reference), input.table_reference, allocator, &body_buf);
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
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConfiguredTableOutput {
    const result: CreateConfiguredTableOutput = try aws.json.parseJsonObject(
        CreateConfiguredTableOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
