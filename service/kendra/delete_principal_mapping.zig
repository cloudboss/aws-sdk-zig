const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeletePrincipalMappingInput = struct {
    /// The identifier of the data source you want to delete a group from.
    ///
    /// A group can be tied to multiple data sources. You can delete a group from
    /// accessing
    /// documents in a certain data source. For example, the groups "Research",
    /// "Engineering",
    /// and "Sales and Marketing" are all tied to the company's documents stored in
    /// the data
    /// sources Confluence and Salesforce. You want to delete "Research" and
    /// "Engineering"
    /// groups from Salesforce, so that these groups cannot access customer-related
    /// documents
    /// stored in Salesforce. Only "Sales and Marketing" should access documents in
    /// the
    /// Salesforce data source.
    data_source_id: ?[]const u8 = null,

    /// The identifier of the group you want to delete.
    group_id: []const u8,

    /// The identifier of the index you want to delete a group from.
    index_id: []const u8,

    /// The timestamp identifier you specify to ensure Amazon Kendra does not
    /// override
    /// the latest `DELETE` action with previous actions. The highest number ID,
    /// which is the ordering ID, is the latest action you want to process and apply
    /// on top of
    /// other actions with lower number IDs. This prevents previous actions with
    /// lower number
    /// IDs from possibly overriding the latest action.
    ///
    /// The ordering ID can be the Unix time of the last update you made to a group
    /// members
    /// list. You would then provide this list when calling `PutPrincipalMapping`.
    /// This ensures your `DELETE` action for that updated group with the latest
    /// members list doesn't get overwritten by earlier `DELETE` actions for the
    /// same
    /// group which are yet to be processed.
    ///
    /// The default ordering ID is the current Unix time in milliseconds that the
    /// action was
    /// received by Amazon Kendra.
    ordering_id: ?i64 = null,

    pub const json_field_names = .{
        .data_source_id = "DataSourceId",
        .group_id = "GroupId",
        .index_id = "IndexId",
        .ordering_id = "OrderingId",
    };
};

pub const DeletePrincipalMappingOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePrincipalMappingInput, options: CallOptions) !DeletePrincipalMappingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePrincipalMappingInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.DeletePrincipalMapping");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePrincipalMappingOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
