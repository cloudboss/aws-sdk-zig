const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DescribePortfolioShareType = @import("describe_portfolio_share_type.zig").DescribePortfolioShareType;
const PortfolioShareDetail = @import("portfolio_share_detail.zig").PortfolioShareDetail;

pub const DescribePortfolioSharesInput = struct {
    /// The maximum number of items to return with this call.
    page_size: i32 = 0,

    /// The page token for the next set of results. To retrieve the first set of
    /// results, use null.
    page_token: ?[]const u8 = null,

    /// The unique identifier of the portfolio for which shares will be retrieved.
    portfolio_id: []const u8,

    /// The type of portfolio share to summarize. This field acts as a filter on the
    /// type of portfolio share, which can be one of the following:
    ///
    /// 1. `ACCOUNT` - Represents an external account to account share.
    ///
    /// 2. `ORGANIZATION` - Represents a share to an organization. This share is
    /// available to every account in the organization.
    ///
    /// 3. `ORGANIZATIONAL_UNIT` - Represents a share to an organizational unit.
    ///
    /// 4. `ORGANIZATION_MEMBER_ACCOUNT` - Represents a share to an account in the
    /// organization.
    @"type": DescribePortfolioShareType,

    pub const json_field_names = .{
        .page_size = "PageSize",
        .page_token = "PageToken",
        .portfolio_id = "PortfolioId",
        .@"type" = "Type",
    };
};

pub const DescribePortfolioSharesOutput = struct {
    /// The page token to use to retrieve the next set of results. If there are no
    /// additional results, this value is null.
    next_page_token: ?[]const u8 = null,

    /// Summaries about each of the portfolio shares.
    portfolio_share_details: ?[]const PortfolioShareDetail = null,

    pub const json_field_names = .{
        .next_page_token = "NextPageToken",
        .portfolio_share_details = "PortfolioShareDetails",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePortfolioSharesInput, options: Options) !DescribePortfolioSharesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "servicecatalog");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribePortfolioSharesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog", "Service Catalog", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AWS242ServiceCatalogService.DescribePortfolioShares");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribePortfolioSharesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribePortfolioSharesOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "DuplicateResourceException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParametersException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameters_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
    if (std.mem.eql(u8, error_code, "TagOptionNotMigratedException")) {
        return .{ .arena = arena, .kind = .{ .tag_option_not_migrated_exception = .{
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
