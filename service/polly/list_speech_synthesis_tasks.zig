const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskStatus = @import("task_status.zig").TaskStatus;
const SynthesisTask = @import("synthesis_task.zig").SynthesisTask;

pub const ListSpeechSynthesisTasksInput = struct {
    /// Maximum number of speech synthesis tasks returned in a List
    /// operation.
    max_results: ?i32 = null,

    /// The pagination token to use in the next request to continue the
    /// listing of speech synthesis tasks.
    next_token: ?[]const u8 = null,

    /// Status of the speech synthesis tasks returned in a List
    /// operation
    status: ?TaskStatus = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub const ListSpeechSynthesisTasksOutput = struct {
    /// An opaque pagination token returned from the previous List operation
    /// in this request. If present, this indicates where to continue the
    /// listing.
    next_token: ?[]const u8 = null,

    /// List of SynthesisTask objects that provides information from the
    /// specified task in the list request, including output format, creation
    /// time, task status, and so on.
    synthesis_tasks: ?[]const SynthesisTask = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .synthesis_tasks = "SynthesisTasks",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSpeechSynthesisTasksInput, options: CallOptions) !ListSpeechSynthesisTasksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "polly", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSpeechSynthesisTasksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("polly", "Polly", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/synthesisTasks";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSpeechSynthesisTasksOutput {
    const result: ListSpeechSynthesisTasksOutput = try aws.json.parseJsonObject(
        ListSpeechSynthesisTasksOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
