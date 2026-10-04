const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProcessingType = @import("processing_type.zig").ProcessingType;
const Record = @import("record.zig").Record;
const FailedRecord = @import("failed_record.zig").FailedRecord;
const MatchGroup = @import("match_group.zig").MatchGroup;

pub const GenerateMatchIdInput = struct {
    /// The processing mode that determines how Match IDs are generated and results
    /// are saved. Each mode provides different levels of accuracy, response time,
    /// and completeness of results.
    ///
    /// If not specified, defaults to `CONSISTENT`.
    ///
    /// `CONSISTENT`: Performs immediate lookup and matching against all existing
    /// records, with results saved synchronously. Provides highest accuracy but
    /// slower response time.
    ///
    /// `EVENTUAL` (shown as *Background* in the console): Performs initial match ID
    /// lookup or generation immediately, with record updates processed
    /// asynchronously in the background. Offers faster initial response time, with
    /// complete matching results available later in S3.
    ///
    /// `EVENTUAL_NO_LOOKUP` (shown as *Quick ID generation* in the console):
    /// Generates new match IDs without checking existing matches, with updates
    /// processed asynchronously. Provides fastest response time but should only be
    /// used for records known to be unique.
    processing_type: ?ProcessingType = null,

    /// The records to match.
    records: []const Record,

    /// The name of the rule-based matching workflow.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .processing_type = "processingType",
        .records = "records",
        .workflow_name = "workflowName",
    };
};

pub const GenerateMatchIdOutput = struct {
    /// The records that didn't receive a generated Match ID.
    failed_records: ?[]const FailedRecord = null,

    /// The match groups from the generated match ID.
    match_groups: ?[]const MatchGroup = null,

    pub const json_field_names = .{
        .failed_records = "failedRecords",
        .match_groups = "matchGroups",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateMatchIdInput, options: CallOptions) !GenerateMatchIdOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "entityresolution", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateMatchIdInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/matchingworkflows/");
    try path_buf.appendSlice(allocator, input.workflow_name);
    try path_buf.appendSlice(allocator, "/generateMatches");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.processing_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"processingType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"records\":");
    try aws.json.writeValue(@TypeOf(input.records), input.records, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateMatchIdOutput {
    var result: GenerateMatchIdOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GenerateMatchIdOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
