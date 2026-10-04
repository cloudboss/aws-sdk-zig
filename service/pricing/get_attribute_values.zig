const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeValue = @import("attribute_value.zig").AttributeValue;

pub const GetAttributeValuesInput = struct {
    /// The name of the attribute that you want to retrieve the values for, such as
    /// `volumeType`.
    attribute_name: []const u8,

    /// The maximum number of results to return in response.
    max_results: ?i32 = null,

    /// The pagination token that indicates the next set of results that you want to
    /// retrieve.
    next_token: ?[]const u8 = null,

    /// The service code for the service whose attributes you want to retrieve. For
    /// example, if you want the retrieve an EC2 attribute, use `AmazonEC2`.
    service_code: []const u8,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .service_code = "ServiceCode",
    };
};

pub const GetAttributeValuesOutput = struct {
    /// The list of values for an attribute. For example, `Throughput Optimized HDD`
    /// and `Provisioned IOPS` are two available values for the `AmazonEC2`
    /// `volumeType`.
    attribute_values: ?[]const AttributeValue = null,

    /// The pagination token that indicates the next set of results to retrieve.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_values = "AttributeValues",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAttributeValuesInput, options: CallOptions) !GetAttributeValuesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAttributeValuesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPriceListService.GetAttributeValues");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAttributeValuesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetAttributeValuesOutput, body, allocator);
}
