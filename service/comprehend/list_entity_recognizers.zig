const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntityRecognizerFilter = @import("entity_recognizer_filter.zig").EntityRecognizerFilter;
const EntityRecognizerProperties = @import("entity_recognizer_properties.zig").EntityRecognizerProperties;

pub const ListEntityRecognizersInput = struct {
    /// Filters the list of entities returned. You can filter on `Status`,
    /// `SubmitTimeBefore`, or `SubmitTimeAfter`. You can only set one filter
    /// at a time.
    filter: ?EntityRecognizerFilter = null,

    /// The maximum number of results to return on each page. The default is 100.
    max_results: ?i32 = null,

    /// Identifies the next page of results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListEntityRecognizersOutput = struct {
    /// The list of properties of an entity recognizer.
    entity_recognizer_properties_list: ?[]const EntityRecognizerProperties = null,

    /// Identifies the next page of results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entity_recognizer_properties_list = "EntityRecognizerPropertiesList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEntityRecognizersInput, options: CallOptions) !ListEntityRecognizersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehend", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEntityRecognizersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehend", "Comprehend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.ListEntityRecognizers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEntityRecognizersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListEntityRecognizersOutput, body, allocator);
}
