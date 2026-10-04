const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InclusionProtectionFilters = @import("inclusion_protection_filters.zig").InclusionProtectionFilters;
const Protection = @import("protection.zig").Protection;

pub const ListProtectionsInput = struct {
    /// Narrows the set of protections that the call retrieves. You can retrieve a
    /// single protection by providing its name or the ARN (Amazon Resource Name) of
    /// its protected resource. You can also retrieve all protections for a specific
    /// resource type. You can provide up to one criteria per filter type. Shield
    /// Advanced returns protections that exactly match all of the filter criteria
    /// that you provide.
    inclusion_filters: ?InclusionProtectionFilters = null,

    /// The greatest number of objects that you want Shield Advanced to return to
    /// the list request. Shield Advanced might return fewer objects
    /// than you indicate in this setting, even if more objects are available. If
    /// there are more objects remaining, Shield Advanced will always also return a
    /// `NextToken` value
    /// in the response.
    ///
    /// The default setting is 20.
    max_results: ?i32 = null,

    /// When you request a list of objects from Shield Advanced, if the response
    /// does not include all of the remaining available objects,
    /// Shield Advanced includes a `NextToken` value in the response. You can
    /// retrieve the next batch of objects by requesting the list again and
    /// providing the token that was returned by the prior call in your request.
    ///
    /// You can indicate the maximum number of objects that you want Shield Advanced
    /// to return for a single call with the `MaxResults`
    /// setting. Shield Advanced will not return more than `MaxResults` objects, but
    /// may return fewer, even if more objects are still available.
    ///
    /// Whenever more objects remain that Shield Advanced has not yet returned to
    /// you, the response will include a `NextToken` value.
    ///
    /// On your first call to a list operation, leave this setting empty.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .inclusion_filters = "InclusionFilters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListProtectionsOutput = struct {
    /// When you request a list of objects from Shield Advanced, if the response
    /// does not include all of the remaining available objects,
    /// Shield Advanced includes a `NextToken` value in the response. You can
    /// retrieve the next batch of objects by requesting the list again and
    /// providing the token that was returned by the prior call in your request.
    ///
    /// You can indicate the maximum number of objects that you want Shield Advanced
    /// to return for a single call with the `MaxResults`
    /// setting. Shield Advanced will not return more than `MaxResults` objects, but
    /// may return fewer, even if more objects are still available.
    ///
    /// Whenever more objects remain that Shield Advanced has not yet returned to
    /// you, the response will include a `NextToken` value.
    next_token: ?[]const u8 = null,

    /// The array of enabled Protection objects.
    protections: ?[]const Protection = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .protections = "Protections",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProtectionsInput, options: CallOptions) !ListProtectionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "shield", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProtectionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("shield", "Shield", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSShield_20160616.ListProtections");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProtectionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListProtectionsOutput, body, allocator);
}
