const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DelegationRequest = @import("delegation_request.zig").DelegationRequest;
const serde = @import("serde.zig");

pub const ListDelegationRequestsInput = struct {
    /// Use this parameter only when paginating results and only after you receive a
    /// response
    /// indicating that the results are truncated. Set it to the value of the
    /// `Marker`
    /// element in the response that you received to indicate where the next
    /// call should start.
    marker: ?[]const u8 = null,

    /// Use this only when paginating results to indicate the maximum number of
    /// items you
    /// want in the response. If additional items exist beyond the maximum you
    /// specify, the
    /// `IsTruncated`
    /// response element is `true`.
    ///
    /// If you do not include this parameter, the number of items defaults to 100.
    /// Note that
    /// IAM may return fewer results, even when there are more results available. In
    /// that case,
    /// the `IsTruncated` response element returns `true`, and
    /// `Marker`
    /// contains a value to include in the subsequent call that tells the
    /// service where to continue from.
    max_items: ?i32 = null,

    /// The owner ID to filter delegation requests by.
    owner_id: ?[]const u8 = null,
};

pub const ListDelegationRequestsOutput = struct {
    /// A list of delegation requests that match the specified criteria.
    delegation_requests: ?[]const DelegationRequest = null,

    /// A flag that indicates whether there are more items to return.
    /// If your results were truncated, you can make a subsequent pagination request
    /// using the `Marker` request parameter to retrieve more items.
    is_truncated: ?bool = null,

    /// When `isTruncated` is `true`, this element is present and contains the value
    /// to use for the `Marker` parameter in a subsequent pagination request.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDelegationRequestsInput, options: CallOptions) !ListDelegationRequestsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iam", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDelegationRequestsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListDelegationRequests&Version=2010-05-08");
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_items) |v| {
        try body_buf.appendSlice(allocator, "&MaxItems=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.owner_id) |v| {
        try body_buf.appendSlice(allocator, "&OwnerId=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDelegationRequestsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListDelegationRequestsResult")) break;
            },
            else => {},
        }
    }

    var result: ListDelegationRequestsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DelegationRequests")) {
                    result.delegation_requests = try serde.deserializedelegationRequestsListType(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "isTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
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
