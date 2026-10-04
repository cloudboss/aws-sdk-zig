const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const SortByType = @import("sort_by_type.zig").SortByType;
const SortOrderType = @import("sort_order_type.zig").SortOrderType;
const SecretListEntry = @import("secret_list_entry.zig").SecretListEntry;

pub const ListSecretsInput = struct {
    /// The filters to apply to the list of secrets.
    filters: ?[]const Filter = null,

    /// Specifies whether to include secrets scheduled for deletion. By default,
    /// secrets
    /// scheduled for deletion aren't included.
    include_planned_deletion: ?bool = null,

    /// The number of results to include in the response.
    ///
    /// If there are more results available, in the response, Secrets Manager
    /// includes
    /// `NextToken`. To get the next results, call `ListSecrets` again
    /// with the value from `NextToken`.
    max_results: ?i32 = null,

    /// A token that indicates where the output should continue from, if a previous
    /// call did
    /// not show all results. To get the next results, call `ListSecrets` again with
    /// this value.
    next_token: ?[]const u8 = null,

    /// If not specified, secrets are listed by `CreatedDate`.
    sort_by: ?SortByType = null,

    /// Secrets are listed by `CreatedDate`.
    sort_order: ?SortOrderType = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .include_planned_deletion = "IncludePlannedDeletion",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListSecretsOutput = struct {
    /// Secrets Manager includes this value if there's more output available than
    /// what is included in
    /// the current response. This can occur even when the response includes no
    /// values at all,
    /// such as when you ask for a filtered view of a long list. To get the next
    /// results, call
    /// `ListSecrets` again with this value.
    next_token: ?[]const u8 = null,

    /// A list of the secrets in the account.
    secret_list: ?[]const SecretListEntry = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .secret_list = "SecretList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSecretsInput, options: CallOptions) !ListSecretsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "secretsmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSecretsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("secretsmanager", "Secrets Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "secretsmanager.ListSecrets");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSecretsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListSecretsOutput, body, allocator);
}
