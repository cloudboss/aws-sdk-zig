const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupOrderingIdSummary = @import("group_ordering_id_summary.zig").GroupOrderingIdSummary;

pub const DescribePrincipalMappingInput = struct {
    /// The identifier of the data source to check the processing of `PUT` and
    /// `DELETE` actions for mapping users to their groups.
    data_source_id: ?[]const u8 = null,

    /// The identifier of the group required to check the processing of `PUT` and
    /// `DELETE` actions for mapping users to their groups.
    group_id: []const u8,

    /// The identifier of the index required to check the processing of `PUT` and
    /// `DELETE` actions for mapping users to their groups.
    index_id: []const u8,

    pub const json_field_names = .{
        .data_source_id = "DataSourceId",
        .group_id = "GroupId",
        .index_id = "IndexId",
    };
};

pub const DescribePrincipalMappingOutput = struct {
    /// Shows the identifier of the data source to see information on the processing
    /// of
    /// `PUT` and `DELETE` actions for mapping users to their
    /// groups.
    data_source_id: ?[]const u8 = null,

    /// Shows the identifier of the group to see information on the processing of
    /// `PUT` and `DELETE` actions for mapping users to their
    /// groups.
    group_id: ?[]const u8 = null,

    /// Shows the following information on the processing of `PUT` and
    /// `DELETE` actions for mapping users to their groups:
    ///
    /// * Status—the status can be either `PROCESSING`,
    /// `SUCCEEDED`, `DELETING`, `DELETED`, or
    /// `FAILED`.
    ///
    /// * Last updated—the last date-time an action was updated.
    ///
    /// * Received—the last date-time an action was received or
    /// submitted.
    ///
    /// * Ordering ID—the latest action that should process and apply after
    /// other actions.
    ///
    /// * Failure reason—the reason an action could not be processed.
    group_ordering_id_summaries: ?[]const GroupOrderingIdSummary = null,

    /// Shows the identifier of the index to see information on the processing of
    /// `PUT` and `DELETE` actions for mapping users to their
    /// groups.
    index_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_source_id = "DataSourceId",
        .group_id = "GroupId",
        .group_ordering_id_summaries = "GroupOrderingIdSummaries",
        .index_id = "IndexId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePrincipalMappingInput, options: CallOptions) !DescribePrincipalMappingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePrincipalMappingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.DescribePrincipalMapping");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePrincipalMappingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribePrincipalMappingOutput, body, allocator);
}
