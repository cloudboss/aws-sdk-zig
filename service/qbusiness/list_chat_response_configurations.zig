const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChatResponseConfiguration = @import("chat_response_configuration.zig").ChatResponseConfiguration;

pub const ListChatResponseConfigurationsInput = struct {
    /// The unique identifier of the Amazon Q Business application for which to list
    /// available chat response configurations.
    application_id: []const u8,

    /// The maximum number of chat response configurations to return in a single
    /// response. This parameter helps control pagination of results when many
    /// configurations exist.
    max_results: ?i32 = null,

    /// A pagination token used to retrieve the next set of results when the number
    /// of configurations exceeds the specified `maxResults` value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListChatResponseConfigurationsOutput = struct {
    /// A list of chat response configuration summaries, each containing key
    /// information about an available configuration in the specified application.
    chat_response_configurations: ?[]const ChatResponseConfiguration = null,

    /// A pagination token that can be used in a subsequent request to retrieve
    /// additional chat response configurations if the results were truncated due to
    /// the `maxResults` parameter.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .chat_response_configurations = "chatResponseConfigurations",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListChatResponseConfigurationsInput, options: CallOptions) !ListChatResponseConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListChatResponseConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/chatresponseconfigurations");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListChatResponseConfigurationsOutput {
    var result: ListChatResponseConfigurationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListChatResponseConfigurationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
