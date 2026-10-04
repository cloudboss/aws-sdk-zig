const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaggedResource = @import("tagged_resource.zig").TaggedResource;
const serde = @import("serde.zig");

pub const DescribeTagsInput = struct {
    /// A value that indicates the starting point for the next set of response
    /// records in a
    /// subsequent request. If a value is returned in a response, you can retrieve
    /// the next set
    /// of records by providing this returned marker value in the `marker` parameter
    /// and retrying the command. If the `marker` field is empty, all response
    /// records have been retrieved for the request.
    marker: ?[]const u8 = null,

    /// The maximum number or response records to return in each call. If the number
    /// of
    /// remaining response records exceeds the specified `MaxRecords` value, a value
    /// is returned in a `marker` field of the response. You can retrieve the next
    /// set of records by retrying the command with the returned `marker` value.
    max_records: ?i32 = null,

    /// The Amazon Resource Name (ARN) for which you want to describe the tag or
    /// tags. For
    /// example, `arn:aws:redshift:us-east-2:123456789:cluster:t1`.
    resource_name: ?[]const u8 = null,

    /// The type of resource with which you want to view tags. Valid resource types
    /// are:
    ///
    /// * Cluster
    ///
    /// * CIDR/IP
    ///
    /// * EC2 security group
    ///
    /// * Snapshot
    ///
    /// * Cluster security group
    ///
    /// * Subnet group
    ///
    /// * HSM connection
    ///
    /// * HSM certificate
    ///
    /// * Parameter group
    ///
    /// * Snapshot copy grant
    ///
    /// * Integration (zero-ETL integration or S3 event integration)
    ///
    /// To describe the tags associated with an `integration`, don't specify
    /// `ResourceType`,
    /// instead specify the `ResourceName` of the integration.
    ///
    /// For more information about Amazon Redshift resource types and constructing
    /// ARNs, go to
    /// [Specifying Policy Elements: Actions, Effects, Resources, and
    /// Principals](https://docs.aws.amazon.com/redshift/latest/mgmt/redshift-iam-access-control-overview.html#redshift-iam-access-control-specify-actions) in
    /// the Amazon Redshift Cluster Management Guide.
    resource_type: ?[]const u8 = null,

    /// A tag key or keys for which you want to return all matching resources that
    /// are
    /// associated with the specified key or keys. For example, suppose that you
    /// have resources
    /// tagged with keys called `owner` and `environment`. If you specify
    /// both of these tag keys in the request, Amazon Redshift returns a response
    /// with all resources
    /// that have either or both of these tag keys associated with them.
    tag_keys: ?[]const []const u8 = null,

    /// A tag value or values for which you want to return all matching resources
    /// that are
    /// associated with the specified value or values. For example, suppose that you
    /// have
    /// resources tagged with values called `admin` and `test`. If you
    /// specify both of these tag values in the request, Amazon Redshift returns a
    /// response with all
    /// resources that have either or both of these tag values associated with them.
    tag_values: ?[]const []const u8 = null,
};

pub const DescribeTagsOutput = struct {
    /// A value that indicates the starting point for the next set of response
    /// records in a
    /// subsequent request. If a value is returned in a response, you can retrieve
    /// the next set
    /// of records by providing this returned marker value in the `Marker` parameter
    /// and retrying the command. If the `Marker` field is empty, all response
    /// records have been retrieved for the request.
    marker: ?[]const u8 = null,

    /// A list of tags with their associated resources.
    tagged_resources: ?[]const TaggedResource = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTagsInput, options: CallOptions) !DescribeTagsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTagsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeTags&Version=2012-12-01");
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.resource_name) |v| {
        try body_buf.appendSlice(allocator, "&ResourceName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.resource_type) |v| {
        try body_buf.appendSlice(allocator, "&ResourceType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tag_keys) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagKeys.TagKey.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.tag_values) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagValues.TagValue.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTagsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeTagsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeTagsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TaggedResources")) {
                    result.tagged_resources = try serde.deserializeTaggedResourceList(allocator, &reader, "TaggedResource");
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
