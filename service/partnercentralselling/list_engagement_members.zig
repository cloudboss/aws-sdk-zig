const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EngagementMember = @import("engagement_member.zig").EngagementMember;

pub const ListEngagementMembersInput = struct {
    /// The catalog related to the request.
    catalog: []const u8,

    /// Identifier of the Engagement record to retrieve members from.
    identifier: []const u8,

    /// The maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .identifier = "Identifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListEngagementMembersOutput = struct {
    /// Provides a list of engagement members.
    engagement_member_list: ?[]const EngagementMember = null,

    /// A pagination token used to retrieve the next set of results. If there are
    /// more results available than can be returned in a single response, this token
    /// will be present. Use this token in a subsequent request to retrieve the next
    /// page of results. If there are no more results, this value will be null.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .engagement_member_list = "EngagementMemberList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEngagementMembersInput, options: CallOptions) !ListEngagementMembersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEngagementMembersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.ListEngagementMembers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEngagementMembersOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListEngagementMembersOutput, body, allocator);
}
