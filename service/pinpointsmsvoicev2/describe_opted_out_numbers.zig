const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OptedOutFilter = @import("opted_out_filter.zig").OptedOutFilter;
const OptedOutNumberInformation = @import("opted_out_number_information.zig").OptedOutNumberInformation;

pub const DescribeOptedOutNumbersInput = struct {
    /// An array of OptedOutFilter objects to filter the results on.
    filters: ?[]const OptedOutFilter = null,

    /// The maximum number of results to return per each request.
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results. You don't need
    /// to supply a value for this field in the initial request.
    next_token: ?[]const u8 = null,

    /// An array of phone numbers to search for in the OptOutList.
    ///
    /// If you specify an opted out number that isn't valid, an exception is
    /// returned.
    opted_out_numbers: ?[]const []const u8 = null,

    /// The OptOutListName or OptOutListArn of the OptOutList. You can use
    /// DescribeOptOutLists to find the values for OptOutListName and OptOutListArn.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    opt_out_list_name: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .opted_out_numbers = "OptedOutNumbers",
        .opt_out_list_name = "OptOutListName",
    };
};

pub const DescribeOptedOutNumbersOutput = struct {
    /// The token to be used for the next set of paginated results. If this field is
    /// empty then there are no more results.
    next_token: ?[]const u8 = null,

    /// An array of OptedOutNumbersInformation objects that provide information
    /// about the requested OptedOutNumbers.
    opted_out_numbers: ?[]const OptedOutNumberInformation = null,

    /// The Amazon Resource Name (ARN) of the OptOutList.
    opt_out_list_arn: ?[]const u8 = null,

    /// The name of the OptOutList.
    opt_out_list_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .opted_out_numbers = "OptedOutNumbers",
        .opt_out_list_arn = "OptOutListArn",
        .opt_out_list_name = "OptOutListName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeOptedOutNumbersInput, options: CallOptions) !DescribeOptedOutNumbersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeOptedOutNumbersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.DescribeOptedOutNumbers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeOptedOutNumbersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeOptedOutNumbersOutput, body, allocator);
}
