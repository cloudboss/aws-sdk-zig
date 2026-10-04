const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataShareStatusForConsumer = @import("data_share_status_for_consumer.zig").DataShareStatusForConsumer;
const DataShare = @import("data_share.zig").DataShare;
const serde = @import("serde.zig");

pub const DescribeDataSharesForConsumerInput = struct {
    /// The Amazon Resource Name (ARN) of the consumer namespace that returns in the
    /// list of datashares.
    consumer_arn: ?[]const u8 = null,

    /// An optional parameter that specifies the starting point to return a set of
    /// response
    /// records. When the results of a DescribeDataSharesForConsumer request
    /// exceed the value specified in `MaxRecords`, Amazon Web Services returns a
    /// value in the
    /// `Marker` field of the response. You can retrieve the next set of response
    /// records by providing the returned marker value in the `Marker` parameter and
    /// retrying the request.
    marker: ?[]const u8 = null,

    /// The maximum number of response records to return in each call. If the number
    /// of
    /// remaining response records exceeds the specified `MaxRecords` value, a value
    /// is returned in a `marker` field of the response. You can retrieve the next
    /// set of records by retrying the command with the returned marker value.
    max_records: ?i32 = null,

    /// An identifier giving the status of a datashare in the consumer cluster. If
    /// this field is specified, Amazon
    /// Redshift returns the list of datashares that have the specified status.
    status: ?DataShareStatusForConsumer = null,
};

pub const DescribeDataSharesForConsumerOutput = struct {
    /// Shows the results of datashares available for consumers.
    data_shares: ?[]const DataShare = null,

    /// An optional parameter that specifies the starting point to return a set of
    /// response
    /// records. When the results of a DescribeDataSharesForConsumer request
    /// exceed the value specified in `MaxRecords`, Amazon Web Services returns a
    /// value in the
    /// `Marker` field of the response. You can retrieve the next set of response
    /// records by providing the returned marker value in the `Marker` parameter and
    /// retrying the request.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDataSharesForConsumerInput, options: CallOptions) !DescribeDataSharesForConsumerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDataSharesForConsumerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeDataSharesForConsumer&Version=2012-12-01");
    if (input.consumer_arn) |v| {
        try body_buf.appendSlice(allocator, "&ConsumerArn=");
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
    if (input.status) |v| {
        try body_buf.appendSlice(allocator, "&Status=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDataSharesForConsumerOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeDataSharesForConsumerResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeDataSharesForConsumerOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DataShares")) {
                    result.data_shares = try serde.deserializeDataShareList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
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
