const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "pricing");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListPriceListsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.pricing", "Pricing", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExpiredNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .expired_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
