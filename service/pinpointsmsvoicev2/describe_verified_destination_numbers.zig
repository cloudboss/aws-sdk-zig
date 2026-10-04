const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VerifiedDestinationNumberFilter = @import("verified_destination_number_filter.zig").VerifiedDestinationNumberFilter;
const VerifiedDestinationNumberInformation = @import("verified_destination_number_information.zig").VerifiedDestinationNumberInformation;

pub const DescribeVerifiedDestinationNumbersInput = struct {
    /// An array of verified destination phone number, in E.164 format.
    destination_phone_numbers: ?[]const []const u8 = null,

    /// An array of VerifiedDestinationNumberFilter objects to filter the results.
    filters: ?[]const VerifiedDestinationNumberFilter = null,

    /// The maximum number of results to return per each request.
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results. You don't need
    /// to supply a value for this field in the initial request.
    next_token: ?[]const u8 = null,

    /// An array of VerifiedDestinationNumberid to retrieve.
    verified_destination_number_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .destination_phone_numbers = "DestinationPhoneNumbers",
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .verified_destination_number_ids = "VerifiedDestinationNumberIds",
    };
};

pub const DescribeVerifiedDestinationNumbersOutput = struct {
    /// The token to be used for the next set of paginated results. You don't need
    /// to supply a value for this field in the initial request.
    next_token: ?[]const u8 = null,

    /// An array of VerifiedDestinationNumberInformation objects
    verified_destination_numbers: ?[]const VerifiedDestinationNumberInformation = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .verified_destination_numbers = "VerifiedDestinationNumbers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeVerifiedDestinationNumbersInput, options: CallOptions) !DescribeVerifiedDestinationNumbersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeVerifiedDestinationNumbersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.DescribeVerifiedDestinationNumbers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeVerifiedDestinationNumbersOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeVerifiedDestinationNumbersOutput, body, allocator);
}
