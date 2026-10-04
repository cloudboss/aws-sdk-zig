const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupMembers = @import("group_members.zig").GroupMembers;

pub const PutPrincipalMappingInput = struct {
    /// The identifier of the data source you want to map users to their groups.
    ///
    /// This is useful if a group is tied to multiple data sources, but you only
    /// want the
    /// group to access documents of a certain data source. For example, the groups
    /// "Research",
    /// "Engineering", and "Sales and Marketing" are all tied to the company's
    /// documents stored
    /// in the data sources Confluence and Salesforce. However, "Sales and
    /// Marketing" team only
    /// needs access to customer-related documents stored in Salesforce.
    data_source_id: ?[]const u8 = null,

    /// The identifier of the group you want to map its users to.
    group_id: []const u8,

    /// The list that contains your users that belong the same group. This can
    /// include sub groups
    /// that belong to a group.
    ///
    /// For example, the group "Company A" includes the user "CEO" and the sub
    /// groups
    /// "Research", "Engineering", and "Sales and Marketing".
    ///
    /// If you have more than 1000 users and/or sub groups for a single group, you
    /// need to
    /// provide the path to the S3 file that lists your users and sub groups for a
    /// group. Your
    /// sub groups can contain more than 1000 users, but the list of sub groups that
    /// belong to a
    /// group (and/or users) must be no more than 1000.
    group_members: GroupMembers,

    /// The identifier of the index you want to map users to their groups.
    index_id: []const u8,

    /// The timestamp identifier you specify to ensure Amazon Kendra doesn't
    /// override
    /// the latest `PUT` action with previous actions. The highest number ID, which
    /// is the ordering ID, is the latest action you want to process and apply on
    /// top of other
    /// actions with lower number IDs. This prevents previous actions with lower
    /// number IDs from
    /// possibly overriding the latest action.
    ///
    /// The ordering ID can be the Unix time of the last update you made to a group
    /// members
    /// list. You would then provide this list when calling `PutPrincipalMapping`.
    /// This ensures your `PUT` action for that updated group with the latest
    /// members
    /// list doesn't get overwritten by earlier `PUT` actions for the same group
    /// which are yet to be processed.
    ///
    /// The default ordering ID is the current Unix time in milliseconds that the
    /// action was
    /// received by Amazon Kendra.
    ordering_id: ?i64 = null,

    /// The Amazon Resource Name (ARN) of an IAM role that has access to the
    /// S3 file that contains your list of users that belong to a group.
    ///
    /// For more information, see [IAM roles for
    /// Amazon
    /// Kendra](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html#iam-roles-ds).
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_source_id = "DataSourceId",
        .group_id = "GroupId",
        .group_members = "GroupMembers",
        .index_id = "IndexId",
        .ordering_id = "OrderingId",
        .role_arn = "RoleArn",
    };
};

pub const PutPrincipalMappingOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutPrincipalMappingInput, options: CallOptions) !PutPrincipalMappingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutPrincipalMappingInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.PutPrincipalMapping");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutPrincipalMappingOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
