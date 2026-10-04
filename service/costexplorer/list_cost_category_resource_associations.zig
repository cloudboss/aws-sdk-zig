const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CostCategoryResourceAssociation = @import("cost_category_resource_association.zig").CostCategoryResourceAssociation;

pub const ListCostCategoryResourceAssociationsInput = struct {
    /// The unique identifier for your cost category.
    cost_category_arn: ?[]const u8 = null,

    /// The number of entries a paginated response contains.
    max_results: ?i32 = null,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token when the response from a previous call has more results than the
    /// maximum page size.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cost_category_arn = "CostCategoryArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListCostCategoryResourceAssociationsOutput = struct {
    /// A reference to a cost category association that contains information on an
    /// associated resource.
    cost_category_resource_associations: ?[]const CostCategoryResourceAssociation = null,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token when the response from a previous call has more results than the
    /// maximum page size.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cost_category_resource_associations = "CostCategoryResourceAssociations",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCostCategoryResourceAssociationsInput, options: CallOptions) !ListCostCategoryResourceAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCostCategoryResourceAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ce", "Cost Explorer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.ListCostCategoryResourceAssociations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCostCategoryResourceAssociationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListCostCategoryResourceAssociationsOutput, body, allocator);
}
