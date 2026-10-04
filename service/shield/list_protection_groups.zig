const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InclusionProtectionGroupFilters = @import("inclusion_protection_group_filters.zig").InclusionProtectionGroupFilters;
const ProtectionGroup = @import("protection_group.zig").ProtectionGroup;

pub const ListProtectionGroupsInput = struct {
    /// Narrows the set of protection groups that the call retrieves. You can
    /// retrieve a single protection group by its name and you can retrieve all
    /// protection groups that are configured with specific pattern or aggregation
    /// settings. You can provide up to one criteria per filter type. Shield
    /// Advanced returns the protection groups that exactly match all of the search
    /// criteria that you provide.
    inclusion_filters: ?InclusionProtectionGroupFilters = null,

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

pub const ListProtectionGroupsOutput = struct {
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

    protection_groups: ?[]const ProtectionGroup = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .protection_groups = "ProtectionGroups",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProtectionGroupsInput, options: CallOptions) !ListProtectionGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProtectionGroupsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSShield_20160616.ListProtectionGroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProtectionGroupsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListProtectionGroupsOutput, body, allocator);
}
