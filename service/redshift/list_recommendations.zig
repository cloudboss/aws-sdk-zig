const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Recommendation = @import("recommendation.zig").Recommendation;
const serde = @import("serde.zig");

pub const ListRecommendationsInput = struct {
    /// The unique identifier of the Amazon Redshift cluster for which the list of
    /// Advisor recommendations is returned.
    /// If the neither the cluster identifier and the cluster namespace ARN
    /// parameters are specified, then recommendations for all clusters in the
    /// account are returned.
    cluster_identifier: ?[]const u8 = null,

    /// A value that indicates the starting point for the next set of response
    /// records in a subsequent request. If a
    /// value is returned in a response, you can retrieve the next set
    /// of records by providing this returned marker value in the Marker parameter
    /// and retrying the command. If the Marker field is empty, all response
    /// records have been retrieved for the request.
    marker: ?[]const u8 = null,

    /// The maximum number of response records to return in each call. If the number
    /// of remaining response records
    /// exceeds the specified MaxRecords value, a value is returned in a marker
    /// field of the response. You can retrieve
    /// the next set of records by retrying the command with the returned marker
    /// value.
    max_records: ?i32 = null,

    /// The Amazon Redshift cluster namespace Amazon Resource Name (ARN) for which
    /// the list of Advisor recommendations is returned.
    /// If the neither the cluster identifier and the cluster namespace ARN
    /// parameters are specified, then recommendations for all clusters in the
    /// account are returned.
    namespace_arn: ?[]const u8 = null,
};

pub const ListRecommendationsOutput = struct {
    /// A value that indicates the starting point for the next set of response
    /// records in a subsequent
    /// request. If a value is returned in a response, you can retrieve the next set
    /// of records by providing this returned marker value in the Marker parameter
    /// and retrying the command. If the Marker field is empty, all response
    /// records have been retrieved for the request.
    marker: ?[]const u8 = null,

    /// The Advisor recommendations for action on the Amazon Redshift cluster.
    recommendations: ?[]const Recommendation = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRecommendationsInput, options: CallOptions) !ListRecommendationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListRecommendations&Version=2012-12-01");
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
    if (input.namespace_arn) |v| {
        try body_buf.appendSlice(allocator, "&NamespaceArn=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRecommendationsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListRecommendationsResult")) break;
            },
            else => {},
        }
    }

    var result: ListRecommendationsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Recommendations")) {
                    result.recommendations = try serde.deserializeRecommendationList(allocator, &reader, "Recommendation");
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
