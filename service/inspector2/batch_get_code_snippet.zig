const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CodeSnippetResult = @import("code_snippet_result.zig").CodeSnippetResult;
const CodeSnippetError = @import("code_snippet_error.zig").CodeSnippetError;

pub const BatchGetCodeSnippetInput = struct {
    /// An array of finding ARNs for the findings you want to retrieve code snippets
    /// from.
    finding_arns: []const []const u8,

    pub const json_field_names = .{
        .finding_arns = "findingArns",
    };
};

pub const BatchGetCodeSnippetOutput = struct {
    /// The retrieved code snippets associated with the provided finding ARNs.
    code_snippet_results: ?[]const CodeSnippetResult = null,

    /// Any errors Amazon Inspector encountered while trying to retrieve the
    /// requested code
    /// snippets.
    errors: ?[]const CodeSnippetError = null,

    pub const json_field_names = .{
        .code_snippet_results = "codeSnippetResults",
        .errors = "errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetCodeSnippetInput, options: CallOptions) !BatchGetCodeSnippetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetCodeSnippetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/codesnippet/batchget";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"findingArns\":");
    try aws.json.writeValue(@TypeOf(input.finding_arns), input.finding_arns, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetCodeSnippetOutput {
    var result: BatchGetCodeSnippetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetCodeSnippetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
