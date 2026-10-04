const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserType = @import("user_type.zig").UserType;

pub const ListUsersInput = struct {
    /// A JSON array of user attribute names, for example `given_name`, that you
    /// want Amazon Cognito to include in the response for each user. When you don't
    /// provide an
    /// `AttributesToGet` parameter, Amazon Cognito returns all attributes for each
    /// user.
    ///
    /// Use `AttributesToGet` with required attributes in your user pool, or in
    /// conjunction with `Filter`. Amazon Cognito returns an error if not all users
    /// in the
    /// results have set a value for the attribute you request. Attributes that you
    /// can't
    /// filter on, including custom attributes, must have a value set in every user
    /// profile
    /// before an `AttributesToGet` parameter returns results.
    attributes_to_get: ?[]const []const u8 = null,

    /// A filter string of the form `"AttributeName Filter-Type "AttributeValue"`.
    /// Quotation marks within the filter string must be escaped using the backslash
    /// (`\`) character. For example, `"family_name =
    /// \"Reddy\""`.
    ///
    /// * *AttributeName*: The name of the attribute to search for.
    /// You can only search for one attribute at a time.
    ///
    /// * *Filter-Type*: For an exact match, use `=`, for
    /// example, "`given_name = \"Jon\"`". For a prefix ("starts with")
    /// match, use `^=`, for example, "`given_name ^= \"Jon\"`".
    ///
    /// * *AttributeValue*: The attribute value that must be matched
    /// for each user.
    ///
    /// If the filter string is empty, `ListUsers` returns all users in the user
    /// pool.
    ///
    /// You can only search for the following standard attributes:
    ///
    /// * `username` (case-sensitive)
    ///
    /// * `email`
    ///
    /// * `phone_number`
    ///
    /// * `name`
    ///
    /// * `given_name`
    ///
    /// * `family_name`
    ///
    /// * `preferred_username`
    ///
    /// * `cognito:user_status` (called **Status** in the Console)
    ///   (case-insensitive)
    ///
    /// * `status (called **Enabled** in the Console)
    /// (case-sensitive)`
    ///
    /// * `sub`
    ///
    /// Custom attributes aren't searchable.
    ///
    /// You can also list users with a client-side filter. The server-side filter
    /// matches
    /// no more than one attribute. For an advanced search, use a client-side filter
    /// with
    /// the `--query` parameter of the `list-users` action in the
    /// CLI. When you use a client-side filter, ListUsers returns a paginated list
    /// of zero
    /// or more users. You can receive multiple pages in a row with zero results.
    /// Repeat the
    /// query with each pagination token that is returned until you receive a null
    /// pagination token value, and then review the combined result.
    ///
    /// For more information about server-side and client-side filtering, see
    /// [FilteringCLI
    /// output](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-filter.html) in the [Command Line Interface
    /// User
    /// Guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-filter.html).
    ///
    /// For more information, see [Searching for Users Using the ListUsers
    /// API](https://docs.aws.amazon.com/cognito/latest/developerguide/how-to-manage-user-accounts.html#cognito-user-pools-searching-for-users-using-listusers-api) and [Examples of Using the ListUsers API](https://docs.aws.amazon.com/cognito/latest/developerguide/how-to-manage-user-accounts.html#cognito-user-pools-searching-for-users-listusers-api-examples) in the *Amazon Cognito Developer
    /// Guide*.
    filter: ?[]const u8 = null,

    /// The maximum number of users that you want Amazon Cognito to return in the
    /// response. In some SDK
    /// contexts, this operation might return fewer items than you specify in the
    /// `Limit` parameter without having reached the end of the full list. If the
    /// response contains a `PaginationToken`, then there are more results.
    limit: ?i32 = null,

    /// This API operation returns a limited number of results. The pagination token
    /// is
    /// an identifier that you can present in an additional API request with the
    /// same parameters. When
    /// you include the pagination token, Amazon Cognito returns the next set of
    /// items after the current list.
    /// Subsequent requests return a new pagination token. By use of this token, you
    /// can paginate
    /// through the full list of items.
    pagination_token: ?[]const u8 = null,

    /// The ID of the user pool where you want to display or search for users.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .attributes_to_get = "AttributesToGet",
        .filter = "Filter",
        .limit = "Limit",
        .pagination_token = "PaginationToken",
        .user_pool_id = "UserPoolId",
    };
};

pub const ListUsersOutput = struct {
    /// The identifier that Amazon Cognito returned with the previous request to
    /// this operation. When
    /// you include a pagination token in your request, Amazon Cognito returns the
    /// next set of items in
    /// the list. By use of this token, you can paginate through the full list of
    /// items.
    pagination_token: ?[]const u8 = null,

    /// An array of user pool users who match your query, and their attributes.
    /// Between
    /// different requests, you might observe variations in the sequence that users
    /// in this
    /// response object are sorted into. The sort order of users isn't guaranteed to
    /// follow a
    /// single pattern, but the paginated list from a single chain of requests won't
    /// return
    /// duplicates.
    users: ?[]const UserType = null,

    pub const json_field_names = .{
        .pagination_token = "PaginationToken",
        .users = "Users",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListUsersInput, options: CallOptions) !ListUsersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-idp", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListUsersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-idp", "Cognito Identity Provider", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.ListUsers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListUsersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListUsersOutput, body, allocator);
}
