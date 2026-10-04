const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceType = @import("resource_type.zig").ResourceType;
const SuggestionQuery = @import("suggestion_query.zig").SuggestionQuery;
const PropertyNameSuggestion = @import("property_name_suggestion.zig").PropertyNameSuggestion;

pub const GetSearchSuggestionsInput = struct {
    /// The name of the SageMaker resource to search for.
    resource: ResourceType,

    /// Limits the property names that are included in the response.
    suggestion_query: ?SuggestionQuery = null,

    pub const json_field_names = .{
        .resource = "Resource",
        .suggestion_query = "SuggestionQuery",
    };
};

pub const GetSearchSuggestionsOutput = struct {
    /// A list of property names for a `Resource` that match a `SuggestionQuery`.
    property_name_suggestions: ?[]const PropertyNameSuggestion = null,

    pub const json_field_names = .{
        .property_name_suggestions = "PropertyNameSuggestions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSearchSuggestionsInput, options: CallOptions) !GetSearchSuggestionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSearchSuggestionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.GetSearchSuggestions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSearchSuggestionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSearchSuggestionsOutput, body, allocator);
}
