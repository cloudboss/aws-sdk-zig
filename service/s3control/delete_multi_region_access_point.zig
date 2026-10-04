const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const DeleteMultiRegionAccessPointInput = @import("delete_multi_region_access_point_request.zig").DeleteMultiRegionAccessPointRequest;

pub const DeleteMultiRegionAccessPointOutput = struct {
    /// The request token associated with the request. You can use this token with
    /// [DescribeMultiRegionAccessPointOperation](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DescribeMultiRegionAccessPointOperation.html) to determine the status of asynchronous
    /// requests.
    request_token_arn: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteMultiRegionAccessPointInput, options: CallOptions) !DeleteMultiRegionAccessPointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteMultiRegionAccessPointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v20180820/async-requests/mrap/delete";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<DeleteMultiRegionAccessPointRequest xmlns=\"http://awss3control.amazonaws.com/doc/2018-08-20/\">");
    try body_buf.appendSlice(allocator, "<ClientToken>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.client_token);
    try body_buf.appendSlice(allocator, "</ClientToken>");
    try body_buf.appendSlice(allocator, "<Details>");
    try serde.serializeDeleteMultiRegionAccessPointInput(allocator, &body_buf, input.details);
    try body_buf.appendSlice(allocator, "</Details>");
    try body_buf.appendSlice(allocator, "</DeleteMultiRegionAccessPointRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteMultiRegionAccessPointOutput {
    var result: DeleteMultiRegionAccessPointOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RequestTokenARN")) {
                    result.request_token_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}
