const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceOwner = @import("resource_owner.zig").ResourceOwner;
const ResourceShareStatus = @import("resource_share_status.zig").ResourceShareStatus;
const TagFilter = @import("tag_filter.zig").TagFilter;
const ResourceShare = @import("resource_share.zig").ResourceShare;

pub const GetResourceSharesInput = struct {
    /// Specifies the total number of results that you want included on each page
    /// of the response. If you do not include this parameter, it defaults to a
    /// value that is
    /// specific to the operation. If additional items exist beyond the number you
    /// specify, the
    /// `NextToken` response element is returned with a value (not null).
    /// Include the specified value as the `NextToken` request parameter in the next
    /// call to the operation to get the next part of the results. Note that the
    /// service might
    /// return fewer results than the maximum even when there are more results
    /// available. You
    /// should check `NextToken` after every operation to ensure that you receive
    /// all
    /// of the results.
    max_results: ?i32 = null,

    /// Specifies the name of an individual resource share that you want to retrieve
    /// details
    /// about.
    name: ?[]const u8 = null,

    /// Specifies that you want to receive the next page of results. Valid
    /// only if you received a `NextToken` response in the previous request. If you
    /// did, it indicates that more output is available. Set this parameter to the
    /// value
    /// provided by the previous call's `NextToken` response to request the
    /// next page of results.
    next_token: ?[]const u8 = null,

    /// Specifies that you want to retrieve details of only those resource shares
    /// that use the managed permission with
    /// this [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    permission_arn: ?[]const u8 = null,

    /// Specifies that you want to retrieve details for only those resource shares
    /// that use the
    /// specified version of the managed permission.
    permission_version: ?i32 = null,

    /// Specifies that you want to retrieve details of only those resource shares
    /// that match the
    /// following:
    ///
    /// * **
    /// `SELF`
    /// ** – resource shares that your
    /// account shares with other accounts
    ///
    /// * **
    /// `OTHER-ACCOUNTS`
    /// ** – resource shares
    /// that other accounts share with your account
    resource_owner: ResourceOwner,

    /// Specifies the [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of individual resource shares that you want information about.
    resource_share_arns: ?[]const []const u8 = null,

    /// Specifies that you want to retrieve details of only those resource shares
    /// that have this
    /// status.
    resource_share_status: ?ResourceShareStatus = null,

    /// Specifies that you want to retrieve details of only those resource shares
    /// that match the
    /// specified tag keys and values.
    tag_filters: ?[]const TagFilter = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
        .permission_arn = "permissionArn",
        .permission_version = "permissionVersion",
        .resource_owner = "resourceOwner",
        .resource_share_arns = "resourceShareArns",
        .resource_share_status = "resourceShareStatus",
        .tag_filters = "tagFilters",
    };
};

pub const GetResourceSharesOutput = struct {
    /// If present, this value indicates that more output is available than
    /// is included in the current response. Use this value in the `NextToken`
    /// request parameter in a subsequent call to the operation to get the next part
    /// of the
    /// output. You should repeat this until the `NextToken` response element comes
    /// back as `null`. This indicates that this is the last page of results.
    next_token: ?[]const u8 = null,

    /// An array of objects that contain the information about the resource shares.
    resource_shares: ?[]const ResourceShare = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .resource_shares = "resourceShares",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceSharesInput, options: CallOptions) !GetResourceSharesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ram", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceSharesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ram", "RAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/getresourceshares";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.permission_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"permissionArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.permission_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"permissionVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceOwner\":");
    try aws.json.writeValue(@TypeOf(input.resource_owner), input.resource_owner, allocator, &body_buf);
    has_prev = true;
    if (input.resource_share_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceShareArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_share_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceShareStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tag_filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tagFilters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceSharesOutput {
    const result: GetResourceSharesOutput = try aws.json.parseJsonObject(
        GetResourceSharesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
