const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Detector = @import("detector.zig").Detector;

pub const DescribeDetectorInput = struct {
    /// The name of the detector model whose detectors (instances) you want
    /// information
    /// about.
    detector_model_name: []const u8,

    /// A filter used to limit results to detectors (instances) created because of
    /// the given key
    /// ID.
    key_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .detector_model_name = "detectorModelName",
        .key_value = "keyValue",
    };
};

pub const DescribeDetectorOutput = struct {
    /// Information about the detector (instance).
    detector: ?Detector = null,

    pub const json_field_names = .{
        .detector = "detector",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDetectorInput, options: CallOptions) !DescribeDetectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ioteventsdata", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDetectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.iotevents", "IoT Events Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/detectors/");
    try path_buf.appendSlice(allocator, input.detector_model_name);
    try path_buf.appendSlice(allocator, "/keyValues");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.key_value) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "keyValue=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDetectorOutput {
    var result: DescribeDetectorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeDetectorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
