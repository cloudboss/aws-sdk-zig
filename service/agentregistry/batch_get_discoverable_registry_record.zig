const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegistryRecordsEntry = @import("registry_records_entry.zig").RegistryRecordsEntry;
const BatchGetDiscoverableRegistryRecordError = @import("batch_get_discoverable_registry_record_error.zig").BatchGetDiscoverableRegistryRecordError;
const RegistryRecordSummary = @import("registry_record_summary.zig").RegistryRecordSummary;

pub const BatchGetDiscoverableRegistryRecordInput = struct {
    /// The registry-scoped groups of record IDs to retrieve. Currently, you can
    /// specify exactly one entry.
    entries: []const RegistryRecordsEntry,

    pub const json_field_names = .{
        .entries = "entries",
    };
};

pub const BatchGetDiscoverableRegistryRecordOutput = struct {
    /// The per-record errors for records that could not be retrieved. This list is
    /// empty when all requested records were returned.
    errors: ?[]const BatchGetDiscoverableRegistryRecordError = null,

    /// The records that were successfully retrieved. Each record correlates to the
    /// request by its `recordId`.
    registry_records: ?[]const RegistryRecordSummary = null,

    pub const json_field_names = .{
        .errors = "errors",
        .registry_records = "registryRecords",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetDiscoverableRegistryRecordInput, options: CallOptions) !BatchGetDiscoverableRegistryRecordOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "agent-registry", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetDiscoverableRegistryRecordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("agent-registry", "Agent Registry", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/discoverable-records-batch";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"entries\":");
    try aws.json.writeValue(@TypeOf(input.entries), input.entries, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetDiscoverableRegistryRecordOutput {
    const result: BatchGetDiscoverableRegistryRecordOutput = try aws.json.parseJsonObject(
        BatchGetDiscoverableRegistryRecordOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
