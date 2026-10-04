const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KeywordFilter = @import("keyword_filter.zig").KeywordFilter;
const KeywordInformation = @import("keyword_information.zig").KeywordInformation;

pub const DescribeKeywordsInput = struct {
    /// An array of keyword filters to filter the results.
    filters: ?[]const KeywordFilter = null,

    /// An array of keywords to search for.
    keywords: ?[]const []const u8 = null,

    /// The maximum number of results to return per each request.
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results. You don't need
    /// to supply a value for this field in the initial request.
    next_token: ?[]const u8 = null,

    /// The origination identity to use such as a PhoneNumberId, PhoneNumberArn,
    /// SenderId or SenderIdArn. You can use DescribePhoneNumbers to find the values
    /// for PhoneNumberId and PhoneNumberArn while DescribeSenderIds can be used to
    /// get the values for SenderId and SenderIdArn.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    origination_identity: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .keywords = "Keywords",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .origination_identity = "OriginationIdentity",
    };
};

pub const DescribeKeywordsOutput = struct {
    /// An array of KeywordInformation objects that contain the results.
    keywords: ?[]const KeywordInformation = null,

    /// The token to be used for the next set of paginated results. If this field is
    /// empty then there are no more results.
    next_token: ?[]const u8 = null,

    /// The PhoneNumberId or PoolId that is associated with the OriginationIdentity.
    origination_identity: ?[]const u8 = null,

    /// The PhoneNumberArn or PoolArn that is associated with the
    /// OriginationIdentity.
    origination_identity_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .keywords = "Keywords",
        .next_token = "NextToken",
        .origination_identity = "OriginationIdentity",
        .origination_identity_arn = "OriginationIdentityArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeKeywordsInput, options: CallOptions) !DescribeKeywordsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sms-voice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeKeywordsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sms-voice", "Pinpoint SMS Voice V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.DescribeKeywords");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeKeywordsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeKeywordsOutput, body, allocator);
}
