const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricGranularityType = @import("metric_granularity_type.zig").MetricGranularityType;
const MetricCollectionType = @import("metric_collection_type.zig").MetricCollectionType;
const serde = @import("serde.zig");

pub const DescribeMetricCollectionTypesInput = struct {};

pub const DescribeMetricCollectionTypesOutput = struct {
    /// The granularities for the metrics.
    granularities: ?[]const MetricGranularityType = null,

    /// The metrics.
    metrics: ?[]const MetricCollectionType = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMetricCollectionTypesInput, options: CallOptions) !DescribeMetricCollectionTypesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "autoscaling", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMetricCollectionTypesInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeMetricCollectionTypes&Version=2011-01-01");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMetricCollectionTypesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeMetricCollectionTypesResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeMetricCollectionTypesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Granularities")) {
                    result.granularities = try serde.deserializeMetricGranularityTypes(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Metrics")) {
                    result.metrics = try serde.deserializeMetricCollectionTypes(allocator, &reader, "member");
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
