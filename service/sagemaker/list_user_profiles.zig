const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserProfileSortKey = @import("user_profile_sort_key.zig").UserProfileSortKey;
const SortOrder = @import("sort_order.zig").SortOrder;
const UserProfileDetails = @import("user_profile_details.zig").UserProfileDetails;

pub const ListUserProfilesInput = struct {
    /// A parameter by which to filter the results.
    domain_id_equals: ?[]const u8 = null,

    /// This parameter defines the maximum number of results that can be return in a
    /// single response. The `MaxResults` parameter is an upper bound, not a target.
    /// If there are more results available than the value specified, a `NextToken`
    /// is provided in the response. The `NextToken` indicates that the user should
    /// get the next set of results by providing this token as a part of a
    /// subsequent call. The default value for `MaxResults` is 10.
    max_results: ?i32 = null,

    /// If the previous response was truncated, you will receive this token. Use it
    /// in your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// The parameter by which to sort the results. The default is CreationTime.
    sort_by: ?UserProfileSortKey = null,

    /// The sort order for the results. The default is Ascending.
    sort_order: ?SortOrder = null,

    /// A parameter by which to filter the results.
    user_profile_name_contains: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_id_equals = "DomainIdEquals",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .user_profile_name_contains = "UserProfileNameContains",
    };
};

pub const ListUserProfilesOutput = struct {
    /// If the previous response was truncated, you will receive this token. Use it
    /// in your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// The list of user profiles.
    user_profiles: ?[]const UserProfileDetails = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .user_profiles = "UserProfiles",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListUserProfilesInput, options: CallOptions) !ListUserProfilesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListUserProfilesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListUserProfiles");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListUserProfilesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListUserProfilesOutput, body, allocator);
}
