const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PriceList = @import("price_list.zig").PriceList;

pub const ListPriceListsInput = struct {
    /// The three alphabetical character ISO-4217 currency code that the Price List
    /// files are denominated in.
    currency_code: []const u8,

    /// The date that the Price List file prices are effective from.
    effective_date: i64,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// The pagination token that indicates the next set of results that you want to
    /// retrieve.
    next_token: ?[]const u8 = null,

    /// This is used to filter the Price List by Amazon Web Services Region. For
    /// example, to get the price list only for the `US East (N. Virginia)` Region,
    /// use `us-east-1`. If nothing is specified, you retrieve price lists for all
    /// applicable Regions. The available `RegionCode` list can be retrieved from
    /// [GetAttributeValues](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_pricing_GetAttributeValues.html) API.
    region_code: ?[]const u8 = null,

    /// The service code or the Savings Plans service code for the attributes that
    /// you want to retrieve. For example, to get the list of applicable Amazon EC2
    /// price lists, use `AmazonEC2`. For a full list of service codes containing
    /// On-Demand and Reserved Instance (RI) pricing, use the
    /// [DescribeServices](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_pricing_DescribeServices.html#awscostmanagement-pricing_DescribeServices-request-FormatVersion) API.
    ///
    /// To retrieve the Reserved Instance and Compute Savings Plans price lists, use
    /// `ComputeSavingsPlans`.
    ///
    /// To retrieve Machine Learning Savings Plans price lists, use
    /// `MachineLearningSavingsPlans`.
    service_code: []const u8,

    pub const json_field_names = .{
        .currency_code = "CurrencyCode",
        .effective_date = "EffectiveDate",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .region_code = "RegionCode",
        .service_code = "ServiceCode",
    };
};

pub const ListPriceListsOutput = struct {
    /// The pagination token that indicates the next set of results to retrieve.
    next_token: ?[]const u8 = null,

    /// The type of price list references that match your request.
    price_lists: ?[]const PriceList = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .price_lists = "PriceLists",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPriceListsInput, options: CallOptions) !ListPriceListsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPriceListsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPriceListService.ListPriceLists");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPriceListsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPriceListsOutput, body, allocator);
}
