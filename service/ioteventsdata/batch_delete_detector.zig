const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeleteDetectorRequest = @import("delete_detector_request.zig").DeleteDetectorRequest;
const BatchDeleteDetectorErrorEntry = @import("batch_delete_detector_error_entry.zig").BatchDeleteDetectorErrorEntry;

pub const BatchDeleteDetectorInput = struct {
    /// The list of one or more detectors to be deleted.
    detectors: []const DeleteDetectorRequest,

    pub const json_field_names = .{
        .detectors = "detectors",
    };
};

pub const BatchDeleteDetectorOutput = struct {
    /// A list of errors associated with the request, or an empty array (`[]`) if
    /// there are no errors. Each error entry contains a `messageId` that helps you
    /// identify the entry that failed.
    batch_delete_detector_error_entries: ?[]const BatchDeleteDetectorErrorEntry = null,

    pub const json_field_names = .{
        .batch_delete_detector_error_entries = "batchDeleteDetectorErrorEntries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteDetectorInput, options: CallOptions) !BatchDeleteDetectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteDetectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.iotevents", "IoT Events Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/detectors/delete";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"detectors\":");
    try aws.json.writeValue(@TypeOf(input.detectors), input.detectors, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteDetectorOutput {
    var result: BatchDeleteDetectorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchDeleteDetectorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
