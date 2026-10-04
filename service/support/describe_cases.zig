const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CaseDetails = @import("case_details.zig").CaseDetails;

pub const DescribeCasesInput = struct {
    /// The start date for a filtered date search on support case communications.
    /// Case
    /// communications are available for 24 months after creation.
    after_time: ?[]const u8 = null,

    /// The end date for a filtered date search on support case communications. Case
    /// communications are available for 24 months after creation.
    before_time: ?[]const u8 = null,

    /// A list of ID numbers of the support cases you want returned. The maximum
    /// number of
    /// cases is 100.
    case_id_list: ?[]const []const u8 = null,

    /// The ID displayed for a case in the Amazon Web Services Support Center user
    /// interface.
    display_id: ?[]const u8 = null,

    /// Specifies whether to validate the request without actually returning case
    /// data. When set
    /// to `true`, the request is validated but no cases are returned, and the
    /// operation
    /// returns a `DryRunOperationException`. When omitted or set to `false`, the
    /// request runs normally.
    dry_run: ?bool = null,

    /// Specifies whether to include communications in the `DescribeCases`
    /// response. By default, communications are included.
    include_communications: ?bool = null,

    /// Specifies whether to include resolved support cases in the `DescribeCases`
    /// response. By default, resolved cases aren't included.
    include_resolved_cases: ?bool = null,

    /// The language in which Amazon Web Services Support handles the case. Amazon
    /// Web Services Support
    /// currently supports Chinese (“zh”), English ("en"), Japanese ("ja") , Chinese
    /// ("zh"), Spanish ("es"), Portuguese ("pt"), French ("fr"), Korean (“ko”), and
    /// Turkish ("tr"). You must specify the ISO 639-1
    /// code for the `language` parameter if you want support in that language.
    language: ?[]const u8 = null,

    /// The maximum number of results to return before paginating.
    max_results: ?i32 = null,

    /// A resumption point for pagination.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .after_time = "afterTime",
        .before_time = "beforeTime",
        .case_id_list = "caseIdList",
        .display_id = "displayId",
        .dry_run = "dryRun",
        .include_communications = "includeCommunications",
        .include_resolved_cases = "includeResolvedCases",
        .language = "language",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const DescribeCasesOutput = struct {
    /// The details for the cases that match the request.
    cases: ?[]const CaseDetails = null,

    /// A resumption point for pagination.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cases = "cases",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCasesInput, options: CallOptions) !DescribeCasesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "support", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCasesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("support", "Support", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.DescribeCases");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCasesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeCasesOutput, body, allocator);
}
