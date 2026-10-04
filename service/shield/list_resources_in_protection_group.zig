const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListResourcesInProtectionGroupInput = struct {
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

    /// The name of the protection group. You use this to identify the protection
    /// group in lists and to manage the protection group, for example to update,
    /// delete, or describe it.
    protection_group_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .protection_group_id = "ProtectionGroupId",
    };
};

pub const ListResourcesInProtectionGroupOutput = struct {
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

    /// The Amazon Resource Names (ARNs) of the resources that are included in the
    /// protection group.
    resource_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_arns = "ResourceArns",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourcesInProtectionGroupInput, options: CallOptions) !ListResourcesInProtectionGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourcesInProtectionGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSShield_20160616.ListResourcesInProtectionGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourcesInProtectionGroupOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListResourcesInProtectionGroupOutput, body, allocator);
}
