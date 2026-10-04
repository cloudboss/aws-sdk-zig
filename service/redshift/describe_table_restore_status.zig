const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableRestoreStatus = @import("table_restore_status.zig").TableRestoreStatus;
const serde = @import("serde.zig");

pub const DescribeTableRestoreStatusInput = struct {
    /// The Amazon Redshift cluster that the table is being restored to.
    cluster_identifier: ?[]const u8 = null,

    /// An optional pagination token provided by a previous
    /// `DescribeTableRestoreStatus` request. If this parameter is specified, the
    /// response includes only records beyond the marker, up to the value specified
    /// by the
    /// `MaxRecords` parameter.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist
    /// than the specified `MaxRecords` value, a pagination token called a marker is
    /// included in the response so that the remaining results can be retrieved.
    max_records: ?i32 = null,

    /// The identifier of the table restore request to return status for. If you
    /// don't
    /// specify a `TableRestoreRequestId` value, then
    /// `DescribeTableRestoreStatus` returns the status of all in-progress table
    /// restore requests.
    table_restore_request_id: ?[]const u8 = null,
};

pub const DescribeTableRestoreStatusOutput = struct {
    /// A pagination token that can be used in a subsequent
    /// DescribeTableRestoreStatus request.
    marker: ?[]const u8 = null,

    /// A list of status details for one or more table restore requests.
    table_restore_status_details: ?[]const TableRestoreStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTableRestoreStatusInput, options: CallOptions) !DescribeTableRestoreStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTableRestoreStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeTableRestoreStatus&Version=2012-12-01");
    if (input.cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.table_restore_request_id) |v| {
        try body_buf.appendSlice(allocator, "&TableRestoreRequestId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTableRestoreStatusOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeTableRestoreStatusResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeTableRestoreStatusOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableRestoreStatusDetails")) {
                    result.table_restore_status_details = try serde.deserializeTableRestoreStatusList(allocator, &reader, "TableRestoreStatus");
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
