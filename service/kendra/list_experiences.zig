const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExperiencesSummary = @import("experiences_summary.zig").ExperiencesSummary;

pub const ListExperiencesInput = struct {
    /// The identifier of the index for your Amazon Kendra experience.
    index_id: []const u8,

    /// The maximum number of returned Amazon Kendra experiences.
    max_results: ?i32 = null,

    /// If the previous response was incomplete (because there is more data
    /// to retrieve), Amazon Kendra returns a pagination token in the response. You
    /// can use this
    /// pagination token to retrieve the next set of Amazon Kendra experiences.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .index_id = "IndexId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListExperiencesOutput = struct {
    /// If the response is truncated, Amazon Kendra returns this token, which you
    /// can use
    /// in a later request to retrieve the next set of Amazon Kendra experiences.
    next_token: ?[]const u8 = null,

    /// An array of summary information for one or more Amazon Kendra experiences.
    summary_items: ?[]const ExperiencesSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .summary_items = "SummaryItems",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListExperiencesInput, options: CallOptions) !ListExperiencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListExperiencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.ListExperiences");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListExperiencesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListExperiencesOutput, body, allocator);
}
