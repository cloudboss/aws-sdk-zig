const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OutputFormat = @import("output_format.zig").OutputFormat;

pub const ScanSbomInput = struct {
    /// The output format for the vulnerability report.
    output_format: ?OutputFormat = null,

    /// The JSON file for the SBOM you want to scan. The SBOM must be in CycloneDX
    /// 1.5 format. This format limits you to passing 2000 components before
    /// throwing a `ValidException` error.
    sbom: []const u8,

    pub const json_field_names = .{
        .output_format = "outputFormat",
        .sbom = "sbom",
    };
};

pub const ScanSbomOutput = struct {
    /// The vulnerability report for the scanned SBOM.
    sbom: ?[]const u8 = null,

    pub const json_field_names = .{
        .sbom = "sbom",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ScanSbomInput, options: CallOptions) !ScanSbomOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector-scan", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ScanSbomInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector-scan", "Inspector Scan", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/scan/sbom";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.output_format) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"outputFormat\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sbom\":");
    try aws.json.writeValue(@TypeOf(input.sbom), input.sbom, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ScanSbomOutput {
    const result: ScanSbomOutput = try aws.json.parseJsonObject(
        ScanSbomOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
