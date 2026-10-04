const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyStatus = @import("policy_status.zig").PolicyStatus;
const serde = @import("serde.zig");

pub const GetMultiRegionAccessPointPolicyStatusInput = struct {
    /// The Amazon Web Services account ID for the owner of the Multi-Region Access
    /// Point.
    account_id: []const u8,

    /// Specifies the Multi-Region Access Point. The name of the Multi-Region Access
    /// Point is different from the alias. For more
    /// information about the distinction between the name and the alias of an
    /// Multi-Region Access Point, see [Rules for naming Amazon S3 Multi-Region
    /// Access
    /// Points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/CreatingMultiRegionAccessPoints.html#multi-region-access-point-naming) in the
    /// *Amazon S3 User Guide*.
    name: []const u8,
};

pub const GetMultiRegionAccessPointPolicyStatusOutput = struct {
    established: ?PolicyStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMultiRegionAccessPointPolicyStatusInput, options: CallOptions) !GetMultiRegionAccessPointPolicyStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMultiRegionAccessPointPolicyStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20180820/mrap/instances/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/policystatus");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMultiRegionAccessPointPolicyStatusOutput {
    var result: GetMultiRegionAccessPointPolicyStatusOutput = .{};
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
                if (std.mem.eql(u8, e.local, "Established")) {
                    result.established = try serde.deserializePolicyStatus(allocator, &reader);
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
