const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CommunicationTypeOptions = @import("communication_type_options.zig").CommunicationTypeOptions;

pub const DescribeCreateCaseOptionsInput = struct {
    /// The category of problem for the support case. You also use the
    /// DescribeServices operation to get the category code for a service. Each
    /// Amazon Web Services service defines its own set of category codes.
    category_code: []const u8,

    /// The type of issue for the case. You can specify `customer-service` or
    /// `technical`. If you don't specify a value, the default is
    /// `technical`.
    issue_type: []const u8,

    /// The language in which Amazon Web Services Support handles the case. Amazon
    /// Web Services Support
    /// currently supports Chinese (“zh”), English ("en"), Japanese ("ja") and
    /// Korean (“ko”). You must specify the ISO 639-1
    /// code for the `language` parameter if you want support in that language.
    language: []const u8,

    /// The code for the Amazon Web Services service. You can use the
    /// DescribeServices
    /// operation to get the possible `serviceCode` values.
    service_code: []const u8,

    pub const json_field_names = .{
        .category_code = "categoryCode",
        .issue_type = "issueType",
        .language = "language",
        .service_code = "serviceCode",
    };
};

pub const DescribeCreateCaseOptionsOutput = struct {
    /// A JSON-formatted array that contains the available communication type
    /// options, along with the available support
    /// timeframes for the given inputs.
    communication_types: ?[]const CommunicationTypeOptions = null,

    /// Language availability can be any of the following:
    ///
    /// * available
    ///
    /// * best_effort
    ///
    /// * unavailable
    language_availability: ?[]const u8 = null,

    pub const json_field_names = .{
        .communication_types = "communicationTypes",
        .language_availability = "languageAvailability",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCreateCaseOptionsInput, options: CallOptions) !DescribeCreateCaseOptionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCreateCaseOptionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.DescribeCreateCaseOptions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCreateCaseOptionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeCreateCaseOptionsOutput, body, allocator);
}
