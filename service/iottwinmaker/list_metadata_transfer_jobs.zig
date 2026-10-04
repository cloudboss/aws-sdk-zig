const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DestinationType = @import("destination_type.zig").DestinationType;
const ListMetadataTransferJobsFilter = @import("list_metadata_transfer_jobs_filter.zig").ListMetadataTransferJobsFilter;
const SourceType = @import("source_type.zig").SourceType;
const MetadataTransferJobSummary = @import("metadata_transfer_job_summary.zig").MetadataTransferJobSummary;

pub const ListMetadataTransferJobsInput = struct {
    /// The metadata transfer job's destination type.
    destination_type: DestinationType,

    /// An object that filters metadata transfer jobs.
    filters: ?[]const ListMetadataTransferJobsFilter = null,

    /// The maximum number of results to return at one time.
    max_results: ?i32 = null,

    /// The string that specifies the next page of results.
    next_token: ?[]const u8 = null,

    /// The metadata transfer job's source type.
    source_type: SourceType,

    pub const json_field_names = .{
        .destination_type = "destinationType",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .source_type = "sourceType",
    };
};

pub const ListMetadataTransferJobsOutput = struct {
    /// The metadata transfer job summaries.
    metadata_transfer_job_summaries: ?[]const MetadataTransferJobSummary = null,

    /// The string that specifies the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .metadata_transfer_job_summaries = "metadataTransferJobSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMetadataTransferJobsInput, options: CallOptions) !ListMetadataTransferJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsiottwinmaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMetadataTransferJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/metadata-transfer-jobs-list";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinationType\":");
    try aws.json.writeValue(@TypeOf(input.destination_type), input.destination_type, allocator, &body_buf);
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
    try body_buf.appendSlice(allocator, "\"sourceType\":");
    try aws.json.writeValue(@TypeOf(input.source_type), input.source_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMetadataTransferJobsOutput {
    var result: ListMetadataTransferJobsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListMetadataTransferJobsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
