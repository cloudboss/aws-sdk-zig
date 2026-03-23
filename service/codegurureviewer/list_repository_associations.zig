const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ProviderType = @import("provider_type.zig").ProviderType;
const RepositoryAssociationState = @import("repository_association_state.zig").RepositoryAssociationState;
const RepositoryAssociationSummary = @import("repository_association_summary.zig").RepositoryAssociationSummary;

pub const ListRepositoryAssociationsInput = struct {
    /// The maximum number of repository association results returned by
    /// `ListRepositoryAssociations` in paginated output. When this parameter is
    /// used, `ListRepositoryAssociations` only returns `maxResults` results
    /// in a single page with a `nextToken` response element. The remaining results
    /// of
    /// the initial request can be seen by sending another
    /// `ListRepositoryAssociations`
    /// request with the returned `nextToken` value. This value can be between 1 and
    /// 100. If this parameter is not used, `ListRepositoryAssociations` returns up
    /// to
    /// 100 results and a `nextToken` value if applicable.
    max_results: ?i32 = null,

    /// List of repository names to use as a filter.
    names: ?[]const []const u8 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `ListRepositoryAssociations` request where `maxResults` was used
    /// and the results exceeded the value of that parameter. Pagination continues
    /// from the end of
    /// the previous results that returned the `nextToken` value.
    ///
    /// Treat this token as an opaque identifier that is only used to retrieve the
    /// next items
    /// in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    /// List of owners to use as a filter. For Amazon Web Services CodeCommit, it is
    /// the name of the
    /// CodeCommit account that was used to associate the repository. For other
    /// repository source
    /// providers, such as Bitbucket and GitHub Enterprise Server, this is name of
    /// the account that
    /// was used to associate the repository.
    owners: ?[]const []const u8 = null,

    /// List of provider types to use as a filter.
    provider_types: ?[]const ProviderType = null,

    /// List of repository association states to use as a filter.
    ///
    /// The valid repository association states are:
    ///
    /// * **Associated**: The repository association is complete.
    ///
    /// * **Associating**: CodeGuru Reviewer is:
    ///
    /// * Setting up pull request notifications. This is required
    /// for pull requests to trigger a CodeGuru Reviewer review.
    ///
    /// If your repository `ProviderType` is `GitHub`, `GitHub Enterprise Server`,
    /// or `Bitbucket`, CodeGuru Reviewer creates webhooks in your repository to
    /// trigger CodeGuru Reviewer reviews. If you delete these webhooks, reviews of
    /// code in your repository cannot be triggered.
    ///
    /// * Setting up source code access. This is required for CodeGuru Reviewer to
    ///   securely clone code in your repository.
    ///
    /// * **Failed**: The repository failed to associate or disassociate.
    ///
    /// * **Disassociating**: CodeGuru Reviewer is removing the repository's pull
    ///   request notifications and source code access.
    ///
    /// * **Disassociated**: CodeGuru Reviewer successfully disassociated the
    ///   repository. You can create a new association with this repository if you
    ///   want to review source code in it later. You can control access to code
    ///   reviews created in anassociated repository with tags after it has been
    ///   disassociated. For more information, see [Using tags to control access to
    ///   associated
    ///   repositories](https://docs.aws.amazon.com/codeguru/latest/reviewer-ug/auth-and-access-control-using-tags.html) in the *Amazon CodeGuru Reviewer User Guide*.
    states: ?[]const RepositoryAssociationState = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .names = "Names",
        .next_token = "NextToken",
        .owners = "Owners",
        .provider_types = "ProviderTypes",
        .states = "States",
    };
};

pub const ListRepositoryAssociationsOutput = struct {
    /// The `nextToken` value to include in a future `ListRecommendations`
    /// request. When the results of a `ListRecommendations` request exceed
    /// `maxResults`, this value can be used to retrieve the next page of results.
    /// This value is `null` when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// A list of repository associations that meet the criteria of the request.
    repository_association_summaries: ?[]const RepositoryAssociationSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .repository_association_summaries = "RepositoryAssociationSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRepositoryAssociationsInput, options: CallOptions) !ListRepositoryAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codeguru-reviewer");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListRepositoryAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-reviewer", "CodeGuru Reviewer", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/associations";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.names) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "Name=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.owners) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "Owner=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.provider_types) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "ProviderType=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.states) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "State=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRepositoryAssociationsOutput {
    var result: ListRepositoryAssociationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListRepositoryAssociationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
