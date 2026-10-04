const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetPriceListFileUrlInput = struct {
    /// The format that you want to retrieve your Price List files in. The
    /// `FileFormat` can be obtained from the
    /// [ListPriceLists](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_pricing_ListPriceLists.html) response.
    file_format: []const u8,

    /// The unique identifier that maps to where your Price List files are located.
    /// `PriceListArn` can be obtained from the
    /// [ListPriceLists](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_pricing_ListPriceLists.html) response.
    price_list_arn: []const u8,

    pub const json_field_names = .{
        .file_format = "FileFormat",
        .price_list_arn = "PriceListArn",
    };
};

pub const GetPriceListFileUrlOutput = struct {
    /// The URL to download your Price List file from.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .url = "Url",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPriceListFileUrlInput, options: CallOptions) !GetPriceListFileUrlOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPriceListFileUrlInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPriceListService.GetPriceListFileUrl");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPriceListFileUrlOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPriceListFileUrlOutput, body, allocator);
}
