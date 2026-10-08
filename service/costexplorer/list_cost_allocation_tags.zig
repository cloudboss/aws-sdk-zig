const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CostAllocationTagStatus = @import("cost_allocation_tag_status.zig").CostAllocationTagStatus;
const CostAllocationTagType = @import("cost_allocation_tag_type.zig").CostAllocationTagType;
const CostAllocationTag = @import("cost_allocation_tag.zig").CostAllocationTag;

pub const ListCostAllocationTagsInput = struct {
    /// The maximum number of objects that are returned for this request. By
    /// default, the request
    /// returns 100 results.
    max_results: ?i32 = null,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token when
    /// the response from a previous call has more results than the maximum page
    /// size.
    next_token: ?[]const u8 = null,

    /// The status of cost allocation tag keys that are returned for this request.
    status: ?CostAllocationTagStatus = null,

    /// The list of cost allocation tag keys that are returned for this request.
    tag_keys: ?[]const []const u8 = null,

    /// The type of `CostAllocationTag` object that are returned for this request.
    /// The
    /// `AWSGenerated` type tags are tags that Amazon Web Services defines and
    /// applies to
    /// support Amazon Web Services resources for cost allocation purposes. The
    /// `UserDefined` type tags are tags that you define, create, and apply to
    /// resources.
    type: ?CostAllocationTagType = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status = "Status",
        .tag_keys = "TagKeys",
        .type = "Type",
    };
};

pub const ListCostAllocationTagsOutput = struct {
    /// A list of cost allocation tags that includes the detailed metadata for each
    /// one.
    cost_allocation_tags: ?[]const CostAllocationTag = null,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token when
    /// the response from a previous call has more results than the maximum page
    /// size.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cost_allocation_tags = "CostAllocationTags",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCostAllocationTagsInput, options: CallOptions) !ListCostAllocationTagsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCostAllocationTagsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.ListCostAllocationTags");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCostAllocationTagsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListCostAllocationTagsOutput, body, allocator);
}
