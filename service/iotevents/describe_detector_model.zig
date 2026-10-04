const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DetectorModel = @import("detector_model.zig").DetectorModel;

pub const DescribeDetectorModelInput = struct {
    /// The name of the detector model.
    detector_model_name: []const u8,

    /// The version of the detector model.
    detector_model_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .detector_model_name = "detectorModelName",
        .detector_model_version = "detectorModelVersion",
    };
};

pub const DescribeDetectorModelOutput = struct {
    /// Information about the detector model.
    detector_model: ?DetectorModel = null,

    pub const json_field_names = .{
        .detector_model = "detectorModel",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDetectorModelInput, options: CallOptions) !DescribeDetectorModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotevents", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDetectorModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotevents", "IoT Events", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/detector-models/");
    try path_buf.appendSlice(allocator, input.detector_model_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.detector_model_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "version=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDetectorModelOutput {
    var result: DescribeDetectorModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeDetectorModelOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
