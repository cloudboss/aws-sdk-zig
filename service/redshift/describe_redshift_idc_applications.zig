const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RedshiftIdcApplication = @import("redshift_idc_application.zig").RedshiftIdcApplication;
const serde = @import("serde.zig");

pub const DescribeRedshiftIdcApplicationsInput = struct {
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

    /// The ARN for the Redshift application that integrates with IAM Identity
    /// Center.
    redshift_idc_application_arn: ?[]const u8 = null,
};

pub const DescribeRedshiftIdcApplicationsOutput = struct {
    /// A value that indicates the starting point for the next set of response
    /// records in a subsequent
    /// request. If a value is returned in a response, you can retrieve the next set
    /// of records by providing this returned marker value in the Marker parameter
    /// and retrying the command. If the Marker field is empty, all response
    /// records have been retrieved for the request.
    marker: ?[]const u8 = null,

    /// The list of Amazon Redshift IAM Identity Center applications.
    redshift_idc_applications: ?[]const RedshiftIdcApplication = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRedshiftIdcApplicationsInput, options: CallOptions) !DescribeRedshiftIdcApplicationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRedshiftIdcApplicationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeRedshiftIdcApplications&Version=2012-12-01");
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.redshift_idc_application_arn) |v| {
        try body_buf.appendSlice(allocator, "&RedshiftIdcApplicationArn=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRedshiftIdcApplicationsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeRedshiftIdcApplicationsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeRedshiftIdcApplicationsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RedshiftIdcApplications")) {
                    result.redshift_idc_applications = try serde.deserializeRedshiftIdcApplicationList(allocator, &reader, "member");
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
