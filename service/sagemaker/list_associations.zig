const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssociationEdgeType = @import("association_edge_type.zig").AssociationEdgeType;
const SortAssociationsBy = @import("sort_associations_by.zig").SortAssociationsBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const AssociationSummary = @import("association_summary.zig").AssociationSummary;

pub const ListAssociationsInput = struct {
    /// A filter that returns only associations of the specified type.
    association_type: ?AssociationEdgeType = null,

    /// A filter that returns only associations created on or after the specified
    /// time.
    created_after: ?i64 = null,

    /// A filter that returns only associations created on or before the specified
    /// time.
    created_before: ?i64 = null,

    /// A filter that returns only associations with the specified destination
    /// Amazon Resource Name (ARN).
    destination_arn: ?[]const u8 = null,

    /// A filter that returns only associations with the specified destination type.
    destination_type: ?[]const u8 = null,

    /// The maximum number of associations to return in the response. The default
    /// value is 10.
    max_results: ?i32 = null,

    /// If the previous call to `ListAssociations` didn't return the full set of
    /// associations, the call returns a token for getting the next set of
    /// associations.
    next_token: ?[]const u8 = null,

    /// The property used to sort results. The default value is `CreationTime`.
    sort_by: ?SortAssociationsBy = null,

    /// The sort order. The default value is `Descending`.
    sort_order: ?SortOrder = null,

    /// A filter that returns only associations with the specified source ARN.
    source_arn: ?[]const u8 = null,

    /// A filter that returns only associations with the specified source type.
    source_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_type = "AssociationType",
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .destination_arn = "DestinationArn",
        .destination_type = "DestinationType",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .source_arn = "SourceArn",
        .source_type = "SourceType",
    };
};

pub const ListAssociationsOutput = struct {
    /// A list of associations and their properties.
    association_summaries: ?[]const AssociationSummary = null,

    /// A token for getting the next set of associations, if there are any.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_summaries = "AssociationSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAssociationsInput, options: CallOptions) !ListAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListAssociations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAssociationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAssociationsOutput, body, allocator);
}
