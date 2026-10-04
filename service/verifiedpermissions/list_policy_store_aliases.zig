const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyStoreAliasFilter = @import("policy_store_alias_filter.zig").PolicyStoreAliasFilter;
const PolicyStoreAliasItem = @import("policy_store_alias_item.zig").PolicyStoreAliasItem;

pub const ListPolicyStoreAliasesInput = struct {
    /// Specifies a filter to narrow the results. You can filter by `policyStoreId`
    /// to list only the policy store aliases associated with a specific policy
    /// store.
    filter: ?PolicyStoreAliasFilter = null,

    /// Specifies the total number of results that you want included in each
    /// response. If additional items exist beyond the number you specify, the
    /// `NextToken` response element is returned with a value (not null). Include
    /// the specified value as the `NextToken` request parameter in the next call to
    /// the operation to get the next set of results. Note that the service might
    /// return fewer results than the maximum even when there are more results
    /// available. You should check `NextToken` after every operation to ensure that
    /// you receive all of the results.
    ///
    /// If you do not specify this parameter, the operation defaults to 5 policy
    /// store aliases per response. You can specify a maximum of 50 policy store
    /// aliases per response.
    max_results: ?i32 = null,

    /// Specifies that you want to receive the next page of results. Valid only if
    /// you received a `NextToken` response in the previous request. If you did, it
    /// indicates that more output is available. Set this parameter to the value
    /// provided by the previous call's `NextToken` response to request the next
    /// page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListPolicyStoreAliasesOutput = struct {
    /// If present, this value indicates that more output is available than is
    /// included in the current response. Use this value in the `NextToken` request
    /// parameter in a subsequent call to the operation to get the next part of the
    /// output. You should repeat this until the `NextToken` response element comes
    /// back as `null`. This indicates that this is the last page of results.
    next_token: ?[]const u8 = null,

    /// The list of policy store aliases in the account.
    policy_store_aliases: ?[]const PolicyStoreAliasItem = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .policy_store_aliases = "policyStoreAliases",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPolicyStoreAliasesInput, options: CallOptions) !ListPolicyStoreAliasesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "verifiedpermissions", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPolicyStoreAliasesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("verifiedpermissions", "VerifiedPermissions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "VerifiedPermissions.ListPolicyStoreAliases");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPolicyStoreAliasesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListPolicyStoreAliasesOutput, body, allocator);
}
