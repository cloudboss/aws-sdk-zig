const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LabelGroupSummary = @import("label_group_summary.zig").LabelGroupSummary;

pub const ListLabelGroupsInput = struct {
    /// The beginning of the name of the label groups to be listed.
    label_group_name_begins_with: ?[]const u8 = null,

    /// Specifies the maximum number of label groups to list.
    max_results: ?i32 = null,

    /// An opaque pagination token indicating where to continue the listing of label
    /// groups.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .label_group_name_begins_with = "LabelGroupNameBeginsWith",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListLabelGroupsOutput = struct {
    /// A summary of the label groups.
    label_group_summaries: ?[]const LabelGroupSummary = null,

    /// An opaque pagination token indicating where to continue the listing of label
    /// groups.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .label_group_summaries = "LabelGroupSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLabelGroupsInput, options: CallOptions) !ListLabelGroupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lookoutequipment", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLabelGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.ListLabelGroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLabelGroupsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListLabelGroupsOutput, body, allocator);
}
