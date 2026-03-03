const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CapacityManagerStatus = @import("capacity_manager_status.zig").CapacityManagerStatus;
const IngestionStatus = @import("ingestion_status.zig").IngestionStatus;

pub const GetCapacityManagerAttributesInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response.
    /// If you have the required permissions, the error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,
};

pub const GetCapacityManagerAttributesOutput = struct {
    /// The current status of Capacity Manager.
    capacity_manager_status: ?CapacityManagerStatus = null,

    /// The number of active data export configurations for this account. This count
    /// includes all data exports regardless of their current delivery status.
    data_export_count: ?i32 = null,

    /// The timestamp of the earliest data point available in Capacity Manager, in
    /// milliseconds since epoch. This indicates how far back historical data is
    /// available for queries.
    earliest_datapoint_timestamp: ?i64 = null,

    /// The current data ingestion status. Initial ingestion may take several hours
    /// after enabling Capacity Manager.
    ingestion_status: ?IngestionStatus = null,

    /// A descriptive message providing additional details about the current
    /// ingestion status. This may include error information if ingestion has
    /// failed or progress details during initial setup.
    ingestion_status_message: ?[]const u8 = null,

    /// The timestamp of the most recent data point ingested by Capacity Manager, in
    /// milliseconds since epoch. This indicates how current your capacity data is.
    latest_datapoint_timestamp: ?i64 = null,

    /// Indicates whether Organizations access is enabled for cross-account data
    /// aggregation.
    organizations_access: ?bool = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCapacityManagerAttributesInput, options: Options) !GetCapacityManagerAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetCapacityManagerAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=GetCapacityManagerAttributes&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCapacityManagerAttributesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: GetCapacityManagerAttributesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "capacityManagerStatus")) {
                    result.capacity_manager_status = std.meta.stringToEnum(CapacityManagerStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "dataExportCount")) {
                    result.data_export_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "earliestDatapointTimestamp")) {
                    result.earliest_datapoint_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ingestionStatus")) {
                    result.ingestion_status = std.meta.stringToEnum(IngestionStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ingestionStatusMessage")) {
                    result.ingestion_status_message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "latestDatapointTimestamp")) {
                    result.latest_datapoint_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "organizationsAccess")) {
                    result.organizations_access = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
