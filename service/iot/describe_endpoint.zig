const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeEndpointInput = struct {
    /// The endpoint type. Valid endpoint types include:
    ///
    /// * `iot:Data` - Returns a VeriSign signed data endpoint.
    ///
    /// * `iot:Data-ATS` - Returns an ATS signed data endpoint.
    ///
    /// * `iot:CredentialProvider` - Returns an IoT credentials provider API
    /// endpoint.
    ///
    /// * `iot:Jobs` - Returns an IoT device management Jobs API
    /// endpoint.
    ///
    /// We strongly recommend that customers use the newer `iot:Data-ATS` endpoint
    /// type to avoid
    /// issues related to the widespread distrust of Symantec certificate
    /// authorities. ATS Signed Certificates
    /// are more secure and are trusted by most popular browsers.
    endpoint_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint_type = "endpointType",
    };
};

pub const DescribeEndpointOutput = struct {
    /// The endpoint. The format of the endpoint is as follows:
    /// *identifier*.iot.*region*.amazonaws.com.
    endpoint_address: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint_address = "endpointAddress",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEndpointInput, options: CallOptions) !DescribeEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/endpoint";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.endpoint_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "endpointType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEndpointOutput {
    var result: DescribeEndpointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeEndpointOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
