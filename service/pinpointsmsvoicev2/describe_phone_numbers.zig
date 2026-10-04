const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PhoneNumberFilter = @import("phone_number_filter.zig").PhoneNumberFilter;
const Owner = @import("owner.zig").Owner;
const PhoneNumberInformation = @import("phone_number_information.zig").PhoneNumberInformation;

pub const DescribePhoneNumbersInput = struct {
    /// An array of PhoneNumberFilter objects to filter the results.
    filters: ?[]const PhoneNumberFilter = null,

    /// The maximum number of results to return per each request.
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results. You don't need
    /// to supply a value for this field in the initial request.
    next_token: ?[]const u8 = null,

    /// Use `SELF` to filter the list of phone numbers to ones your account owns or
    /// use `SHARED` to filter on phone numbers shared with your account. The
    /// `Owner` and `PhoneNumberIds` parameters can't be used at the same time.
    owner: ?Owner = null,

    /// The unique identifier of phone numbers to find information about. This is an
    /// array of strings that can be either the PhoneNumberId or PhoneNumberArn.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    phone_number_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .owner = "Owner",
        .phone_number_ids = "PhoneNumberIds",
    };
};

pub const DescribePhoneNumbersOutput = struct {
    /// The token to be used for the next set of paginated results. If this field is
    /// empty then there are no more results.
    next_token: ?[]const u8 = null,

    /// An array of PhoneNumberInformation objects that contain the details for the
    /// requested phone numbers.
    phone_numbers: ?[]const PhoneNumberInformation = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .phone_numbers = "PhoneNumbers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePhoneNumbersInput, options: CallOptions) !DescribePhoneNumbersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePhoneNumbersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.DescribePhoneNumbers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePhoneNumbersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribePhoneNumbersOutput, body, allocator);
}
