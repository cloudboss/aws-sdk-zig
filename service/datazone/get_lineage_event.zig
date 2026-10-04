const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LineageEventProcessingStatus = @import("lineage_event_processing_status.zig").LineageEventProcessingStatus;

pub const GetLineageEventInput = struct {
    /// The ID of the domain.
    domain_identifier: []const u8,

    /// The ID of the lineage event.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
    };
};

pub const GetLineageEventOutput = struct {
    /// The timestamp of when the lineage event was created.
    created_at: ?i64 = null,

    /// The user who created the lineage event.
    created_by: ?[]const u8 = null,

    /// The ID of the domain.
    domain_id: ?[]const u8 = null,

    /// The lineage event details.
    event: ?[]const u8 = null,

    /// The time of the lineage event.
    event_time: ?i64 = null,

    /// The ID of the lineage event.
    id: ?[]const u8 = null,

    /// The progressing status of the lineage event.
    processing_status: ?LineageEventProcessingStatus = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .event = "event",
        .event_time = "eventTime",
        .id = "id",
        .processing_status = "processingStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLineageEventInput, options: CallOptions) !GetLineageEventOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLineageEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/lineage/events/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLineageEventOutput {
    var result: GetLineageEventOutput = .{};
    errdefer {
        if (result.created_by) |value| allocator.free(value);
        if (result.domain_id) |value| allocator.free(value);
        if (result.id) |value| allocator.free(value);
        if (result.event) |value| allocator.free(value);
    }
    if (body.len > 0) {
        result.event = try allocator.dupe(u8, body);
    }
    _ = status;
    if (headers.get("created-at")) |value| {
        result.created_at = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (headers.get("created-by")) |value| {
        result.created_by = try allocator.dupe(u8, value);
    }
    if (headers.get("domain-id")) |value| {
        result.domain_id = try allocator.dupe(u8, value);
    }
    if (headers.get("event-time")) |value| {
        result.event_time = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (headers.get("id")) |value| {
        result.id = try allocator.dupe(u8, value);
    }
    if (headers.get("processing-status")) |value| {
        result.processing_status = LineageEventProcessingStatus.fromWireName(value);
    }

    return result;
}
