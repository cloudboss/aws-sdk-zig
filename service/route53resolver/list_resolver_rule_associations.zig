const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const ResolverRuleAssociation = @import("resolver_rule_association.zig").ResolverRuleAssociation;

pub const ListResolverRuleAssociationsInput = struct {
    /// An optional specification to return a subset of Resolver rules, such as
    /// Resolver rules that are associated with the same VPC ID.
    ///
    /// If you submit a second or subsequent `ListResolverRuleAssociations` request
    /// and specify the `NextToken` parameter,
    /// you must use the same values for `Filters`, if any, as in the previous
    /// request.
    filters: ?[]const Filter = null,

    /// The maximum number of rule associations that you want to return in the
    /// response to a `ListResolverRuleAssociations` request.
    /// If you don't specify a value for `MaxResults`, Resolver returns up to 100
    /// rule associations.
    max_results: ?i32 = null,

    /// For the first `ListResolverRuleAssociation` request, omit this value.
    ///
    /// If you have more than `MaxResults` rule associations, you can submit another
    /// `ListResolverRuleAssociation` request
    /// to get the next group of rule associations. In the next request, specify the
    /// value of `NextToken` from the previous response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListResolverRuleAssociationsOutput = struct {
    /// The value that you specified for `MaxResults` in the request.
    max_results: ?i32 = null,

    /// If more than `MaxResults` rule associations match the specified criteria,
    /// you can submit another
    /// `ListResolverRuleAssociation` request to get the next group of results. In
    /// the next request, specify the value of
    /// `NextToken` from the previous response.
    next_token: ?[]const u8 = null,

    /// The associations that were created between Resolver rules and VPCs using the
    /// current Amazon Web Services account, and that match the
    /// specified filters, if any.
    resolver_rule_associations: ?[]const ResolverRuleAssociation = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resolver_rule_associations = "ResolverRuleAssociations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResolverRuleAssociationsInput, options: CallOptions) !ListResolverRuleAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53resolver", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResolverRuleAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53resolver", "Route53Resolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.ListResolverRuleAssociations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResolverRuleAssociationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListResolverRuleAssociationsOutput, body, allocator);
}
