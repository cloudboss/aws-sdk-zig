const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventAccountFilter = @import("event_account_filter.zig").EventAccountFilter;
const OrganizationEventDetailsErrorItem = @import("organization_event_details_error_item.zig").OrganizationEventDetailsErrorItem;
const OrganizationEventDetails = @import("organization_event_details.zig").OrganizationEventDetails;

pub const DescribeEventDetailsForOrganizationInput = struct {
    /// The locale (language) to return information in. English (en) is the default
    /// and the only supported value at this time.
    locale: ?[]const u8 = null,

    /// A set of JSON elements that includes the `awsAccountId` and the
    /// `eventArn`.
    organization_event_detail_filters: []const EventAccountFilter,

    pub const json_field_names = .{
        .locale = "locale",
        .organization_event_detail_filters = "organizationEventDetailFilters",
    };
};

pub const DescribeEventDetailsForOrganizationOutput = struct {
    /// Error messages for any events that could not be retrieved.
    failed_set: ?[]const OrganizationEventDetailsErrorItem = null,

    /// Information about the events that could be retrieved.
    successful_set: ?[]const OrganizationEventDetails = null,

    pub const json_field_names = .{
        .failed_set = "failedSet",
        .successful_set = "successfulSet",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEventDetailsForOrganizationInput, options: CallOptions) !DescribeEventDetailsForOrganizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "health", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEventDetailsForOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("health", "Health", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHealth_20160804.DescribeEventDetailsForOrganization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEventDetailsForOrganizationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeEventDetailsForOrganizationOutput, body, allocator);
}
