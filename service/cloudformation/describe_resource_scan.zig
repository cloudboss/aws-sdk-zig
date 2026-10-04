const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScanFilter = @import("scan_filter.zig").ScanFilter;
const ResourceScanStatus = @import("resource_scan_status.zig").ResourceScanStatus;
const serde = @import("serde.zig");

pub const DescribeResourceScanInput = struct {
    /// The Amazon Resource Name (ARN) of the resource scan.
    resource_scan_id: []const u8,
};

pub const DescribeResourceScanOutput = struct {
    /// The time that the resource scan was finished.
    end_time: ?i64 = null,

    /// The percentage of the resource scan that has been completed.
    percentage_completed: ?f64 = null,

    /// The Amazon Resource Name (ARN) of the resource scan. The format is
    /// `arn:${Partition}:cloudformation:${Region}:${Account}:resourceScan/${Id}`.
    /// An
    /// example is
    /// `arn:aws:cloudformation:*us-east-1*:*123456789012*:resourceScan/*f5b490f7-7ed4-428a-aa06-31ff25db0772*
    /// `.
    resource_scan_id: ?[]const u8 = null,

    /// The number of resources that were read. This is only available for scans
    /// with a
    /// `Status` set to `COMPLETE`, `EXPIRED`, or
    /// `FAILED`.
    ///
    /// This field may be 0 if the resource scan failed with a
    /// `ResourceScanLimitExceededException`.
    resources_read: ?i32 = null,

    /// The number of resources that were listed. This is only available for scans
    /// with a
    /// `Status` set to `COMPLETE`, `EXPIRED`, or `FAILED
    /// `.
    resources_scanned: ?i32 = null,

    /// The list of resource types for the specified scan. Resource types are only
    /// available for
    /// scans with a `Status` set to `COMPLETE` or `FAILED `.
    resource_types: ?[]const []const u8 = null,

    /// The scan filters that were used.
    scan_filters: ?[]const ScanFilter = null,

    /// The time that the resource scan was started.
    start_time: ?i64 = null,

    /// Status of the resource scan.
    ///
    /// **
    ///
    /// IN_PROGRESS
    ///
    /// **
    ///
    /// The resource scan is still in progress.
    ///
    /// **
    ///
    /// COMPLETE
    ///
    /// **
    ///
    /// The resource scan is complete.
    ///
    /// **
    ///
    /// EXPIRED
    ///
    /// **
    ///
    /// The resource scan has expired.
    ///
    /// **
    ///
    /// FAILED
    ///
    /// **
    ///
    /// The resource scan has failed.
    status: ?ResourceScanStatus = null,

    /// The reason for the resource scan status, providing more information if a
    /// failure
    /// happened.
    status_reason: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeResourceScanInput, options: CallOptions) !DescribeResourceScanOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeResourceScanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeResourceScan&Version=2010-05-15");
    try body_buf.appendSlice(allocator, "&ResourceScanId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.resource_scan_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeResourceScanOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeResourceScanResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeResourceScanOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "PercentageCompleted")) {
                    result.percentage_completed = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ResourceScanId")) {
                    result.resource_scan_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourcesRead")) {
                    result.resources_read = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ResourcesScanned")) {
                    result.resources_scanned = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ResourceTypes")) {
                    result.resource_types = try serde.deserializeResourceTypes(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "ScanFilters")) {
                    result.scan_filters = try serde.deserializeScanFilters(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = ResourceScanStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try allocator.dupe(u8, try reader.readElementText());
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
