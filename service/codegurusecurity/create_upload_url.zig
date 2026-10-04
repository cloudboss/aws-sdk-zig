const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateUploadUrlInput = struct {
    /// The name of the scan that will use the uploaded resource. CodeGuru Security
    /// uses the unique scan name to track revisions across multiple scans of the
    /// same resource. Use this `scanName` when you call `CreateScan` on the code
    /// resource you upload to this URL.
    scan_name: []const u8,

    pub const json_field_names = .{
        .scan_name = "scanName",
    };
};

pub const CreateUploadUrlOutput = struct {
    /// The identifier for the uploaded code resource. Pass this to `CreateScan` to
    /// use the uploaded resources.
    code_artifact_id: []const u8,

    /// A set of key-value pairs that contain the required headers when uploading
    /// your resource.
    request_headers: ?[]const aws.map.StringMapEntry = null,

    /// A pre-signed S3 URL. You can upload the code file you want to scan with the
    /// required `requestHeaders` using any HTTP client.
    s_3_url: []const u8,

    pub const json_field_names = .{
        .code_artifact_id = "codeArtifactId",
        .request_headers = "requestHeaders",
        .s_3_url = "s3Url",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUploadUrlInput, options: CallOptions) !CreateUploadUrlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeguru-security", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUploadUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-security", "CodeGuru Security", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/uploadUrl";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scanName\":");
    try aws.json.writeValue(@TypeOf(input.scan_name), input.scan_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUploadUrlOutput {
    var result: CreateUploadUrlOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateUploadUrlOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
