const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentProfileSummary = @import("environment_profile_summary.zig").EnvironmentProfileSummary;

pub const ListEnvironmentProfilesInput = struct {
    /// The identifier of the Amazon Web Services account where you want to list
    /// environment profiles.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon Web Services region where you want to list environment profiles.
    aws_account_region: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain.
    domain_identifier: []const u8,

    /// The identifier of the blueprint that was used to create the environment
    /// profiles that you want to list.
    environment_blueprint_identifier: ?[]const u8 = null,

    /// The maximum number of environment profiles to return in a single call to
    /// `ListEnvironmentProfiles`. When the number of environment profiles to be
    /// listed is greater than the value of `MaxResults`, the response contains a
    /// `NextToken` value that you can use in a subsequent call to
    /// `ListEnvironmentProfiles` to list the next set of environment profiles.
    max_results: ?i32 = null,

    name: ?[]const u8 = null,

    /// When the number of environment profiles is greater than the default value
    /// for the `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of environment profiles, the
    /// response includes a pagination token named `NextToken`. You can specify this
    /// `NextToken` value in a subsequent call to `ListEnvironmentProfiles` to list
    /// the next set of environment profiles.
    next_token: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone project.
    project_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .aws_account_region = "awsAccountRegion",
        .domain_identifier = "domainIdentifier",
        .environment_blueprint_identifier = "environmentBlueprintIdentifier",
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
        .project_identifier = "projectIdentifier",
    };
};

pub const ListEnvironmentProfilesOutput = struct {
    /// The results of the `ListEnvironmentProfiles` action.
    items: ?[]const EnvironmentProfileSummary = null,

    /// When the number of environment profiles is greater than the default value
    /// for the `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of environment profiles, the
    /// response includes a pagination token named `NextToken`. You can specify this
    /// `NextToken` value in a subsequent call to `ListEnvironmentProfiles` to list
    /// the next set of environment profiles.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEnvironmentProfilesInput, options: CallOptions) !ListEnvironmentProfilesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEnvironmentProfilesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environment-profiles");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.aws_account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "awsAccountId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.aws_account_region) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "awsAccountRegion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.environment_blueprint_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "environmentBlueprintIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "name=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.project_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "projectIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEnvironmentProfilesOutput {
    const result: ListEnvironmentProfilesOutput = try aws.json.parseJsonObject(
        ListEnvironmentProfilesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
