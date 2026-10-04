const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FaqSummary = @import("faq_summary.zig").FaqSummary;

pub const ListFaqsInput = struct {
    /// The index for the FAQs.
    index_id: []const u8,

    /// The maximum number of FAQs to return in the response. If there are fewer
    /// results in
    /// the list, this response contains only the actual results.
    max_results: ?i32 = null,

    /// If the previous response was incomplete (because there is more data to
    /// retrieve),
    /// Amazon Kendra returns a pagination token in the response. You can use this
    /// pagination token to retrieve the next set of FAQs.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .index_id = "IndexId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListFaqsOutput = struct {
    /// Summary information about the FAQs for a specified index.
    faq_summary_items: ?[]const FaqSummary = null,

    /// If the response is truncated, Amazon Kendra returns this token that you can
    /// use
    /// in the subsequent request to retrieve the next set of FAQs.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .faq_summary_items = "FaqSummaryItems",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFaqsInput, options: CallOptions) !ListFaqsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFaqsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.ListFaqs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFaqsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListFaqsOutput, body, allocator);
}
