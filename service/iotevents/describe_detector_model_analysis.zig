const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalysisStatus = @import("analysis_status.zig").AnalysisStatus;

pub const DescribeDetectorModelAnalysisInput = struct {
    /// The ID of the analysis result that you want to retrieve.
    analysis_id: []const u8,

    pub const json_field_names = .{
        .analysis_id = "analysisId",
    };
};

pub const DescribeDetectorModelAnalysisOutput = struct {
    /// The status of the analysis activity. The status can be one of the following
    /// values:
    ///
    /// * `RUNNING` - AWS IoT Events is analyzing your detector model. This process
    ///   can take
    /// several minutes to complete.
    ///
    /// * `COMPLETE` - AWS IoT Events finished analyzing your detector model.
    ///
    /// * `FAILED` - AWS IoT Events couldn't analyze your detector model. Try again
    /// later.
    status: ?AnalysisStatus = null,

    pub const json_field_names = .{
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDetectorModelAnalysisInput, options: CallOptions) !DescribeDetectorModelAnalysisOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDetectorModelAnalysisInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotevents", "IoT Events", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/analysis/detector-models/");
    try path_buf.appendSlice(allocator, input.analysis_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDetectorModelAnalysisOutput {
    var result: DescribeDetectorModelAnalysisOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeDetectorModelAnalysisOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
