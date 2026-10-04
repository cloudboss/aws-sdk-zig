const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Service = @import("service.zig").Service;

pub const DescribeServicesInput = struct {
    /// The format version that you want the response to be in.
    ///
    /// Valid values are: `aws_v1`
    format_version: ?[]const u8 = null,

    /// The maximum number of results that you want returned in the response.
    max_results: ?i32 = null,

    /// The pagination token that indicates the next set of results that you want to
    /// retrieve.
    next_token: ?[]const u8 = null,

    /// The code for the service whose information you want to retrieve, such as
    /// `AmazonEC2`. You can use the `ServiceCode` to filter the results in a
    /// `GetProducts` call. To retrieve a list of all services, leave this blank.
    service_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .format_version = "FormatVersion",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .service_code = "ServiceCode",
    };
};

pub const DescribeServicesOutput = struct {
    /// The format version of the response. For example, `aws_v1`.
    format_version: ?[]const u8 = null,

    /// The pagination token for the next set of retrievable results.
    next_token: ?[]const u8 = null,

    /// The service metadata for the service or services in the response.
    services: ?[]const Service = null,

    pub const json_field_names = .{
        .format_version = "FormatVersion",
        .next_token = "NextToken",
        .services = "Services",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeServicesInput, options: CallOptions) !DescribeServicesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pricing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeServicesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.pricing", "Pricing", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPriceListService.DescribeServices");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeServicesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeServicesOutput, body, allocator);
}
