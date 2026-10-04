const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportSpecification = @import("export_specification.zig").ExportSpecification;

pub const StartSearchResultExportJobInput = struct {
    /// Include this parameter to allow multiple identical calls for idempotency.
    ///
    /// A client token is valid for 8 hours after the first request that uses it is
    /// completed. After this time, any request with the same token is treated as a
    /// new request.
    client_token: ?[]const u8 = null,

    /// This specification contains a required string of the destination bucket;
    /// optionally, you can include the destination prefix.
    export_specification: ExportSpecification,

    /// This parameter specifies the role ARN used to start the search results
    /// export jobs.
    role_arn: ?[]const u8 = null,

    /// The unique string that specifies the search job.
    search_job_identifier: []const u8,

    /// Optional tags to include. A tag is a key-value pair you can use to manage,
    /// filter, and search for your resources. Allowed characters include UTF-8
    /// letters, numbers, spaces, and the following characters: + - = . _ : /.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .export_specification = "ExportSpecification",
        .role_arn = "RoleArn",
        .search_job_identifier = "SearchJobIdentifier",
        .tags = "Tags",
    };
};

pub const StartSearchResultExportJobOutput = struct {
    /// This is the unique ARN (Amazon Resource Name) that belongs to the new export
    /// job.
    export_job_arn: ?[]const u8 = null,

    /// This is the unique identifier that specifies the new export job.
    export_job_identifier: []const u8,

    pub const json_field_names = .{
        .export_job_arn = "ExportJobArn",
        .export_job_identifier = "ExportJobIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSearchResultExportJobInput, options: CallOptions) !StartSearchResultExportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup-search", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartSearchResultExportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup-search", "BackupSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/export-search-jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ExportSpecification\":");
    try aws.json.writeValue(@TypeOf(input.export_specification), input.export_specification, allocator, &body_buf);
    has_prev = true;
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SearchJobIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.search_job_identifier), input.search_job_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSearchResultExportJobOutput {
    const result: StartSearchResultExportJobOutput = try aws.json.parseJsonObject(
        StartSearchResultExportJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
