const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContributorInsightsAction = @import("contributor_insights_action.zig").ContributorInsightsAction;
const ContributorInsightsMode = @import("contributor_insights_mode.zig").ContributorInsightsMode;
const ContributorInsightsStatus = @import("contributor_insights_status.zig").ContributorInsightsStatus;

pub const UpdateContributorInsightsInput = struct {
    /// Represents the contributor insights action.
    contributor_insights_action: ContributorInsightsAction,

    /// Specifies whether to track all access and throttled events or throttled
    /// events only for
    /// the DynamoDB table or index.
    contributor_insights_mode: ?ContributorInsightsMode = null,

    /// The global secondary index name, if applicable.
    index_name: ?[]const u8 = null,

    /// The name of the table. You can also provide the Amazon Resource Name (ARN)
    /// of the table in this
    /// parameter.
    table_name: []const u8,

    pub const json_field_names = .{
        .contributor_insights_action = "ContributorInsightsAction",
        .contributor_insights_mode = "ContributorInsightsMode",
        .index_name = "IndexName",
        .table_name = "TableName",
    };
};

pub const UpdateContributorInsightsOutput = struct {
    /// The updated mode of CloudWatch Contributor Insights that determines whether
    /// to monitor
    /// all access and throttled events or to track throttled events exclusively.
    contributor_insights_mode: ?ContributorInsightsMode = null,

    /// The status of contributor insights
    contributor_insights_status: ?ContributorInsightsStatus = null,

    /// The name of the global secondary index, if applicable.
    index_name: ?[]const u8 = null,

    /// The name of the table.
    table_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .contributor_insights_mode = "ContributorInsightsMode",
        .contributor_insights_status = "ContributorInsightsStatus",
        .index_name = "IndexName",
        .table_name = "TableName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateContributorInsightsInput, options: CallOptions) !UpdateContributorInsightsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateContributorInsightsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.UpdateContributorInsights");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateContributorInsightsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateContributorInsightsOutput, body, allocator);
}
