const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupFilter = @import("group_filter.zig").GroupFilter;
const GroupIdentifier = @import("group_identifier.zig").GroupIdentifier;
const Group = @import("group.zig").Group;

pub const ListGroupsInput = struct {
    /// Filters, formatted as GroupFilter objects, that you want to apply to
    /// a `ListGroups` operation.
    ///
    /// * `resource-type` - Filter the results to include only those resource groups
    ///   that have the specified
    /// resource type in their `ResourceTypeFilter`. For example,
    /// `AWS::EC2::Instance` would
    /// return any resource group with a `ResourceTypeFilter` that includes
    /// `AWS::EC2::Instance`.
    ///
    /// * `configuration-type` - Filter the results to include only those
    /// groups that have the specified configuration types attached. The current
    /// supported values are:
    ///
    /// * `AWS::ResourceGroups::ApplicationGroup`
    ///
    /// * `AWS::AppRegistry::Application`
    ///
    /// * `AWS::AppRegistry::ApplicationResourceGroup`
    ///
    /// * `AWS::CloudFormation::Stack`
    ///
    /// * `AWS::EC2::CapacityReservationPool`
    ///
    /// * `AWS::EC2::HostManagement`
    ///
    /// * `AWS::NetworkFirewall::RuleGroup`
    filters: ?[]const GroupFilter = null,

    /// The total number of results that you want included on each page of the
    /// response. If you do not include this parameter, it defaults to a value that
    /// is specific to the
    /// operation. If additional items exist beyond the maximum you specify, the
    /// `NextToken`
    /// response element is present and has a value (is not null). Include that
    /// value as the
    /// `NextToken` request parameter in the next call to the operation to get the
    /// next part
    /// of the results. Note that the service might return fewer results than the
    /// maximum even when there
    /// are more results available. You should check `NextToken` after every
    /// operation to
    /// ensure that you receive all of the results.
    max_results: ?i32 = null,

    /// The parameter for receiving additional results if you receive a
    /// `NextToken` response in a previous request. A `NextToken` response
    /// indicates that more output is available. Set this parameter to the value
    /// provided by a previous
    /// call's `NextToken` response to indicate where the output should continue
    /// from.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListGroupsOutput = struct {
    /// A list of GroupIdentifier objects. Each identifier is an object that
    /// contains both the `Name` and the `GroupArn`.
    group_identifiers: ?[]const GroupIdentifier = null,

    /// *
    /// **Deprecated - don't use this field. Use the
    /// `GroupIdentifiers` response field
    /// instead.**
    /// *
    groups: ?[]const Group = null,

    /// If present, indicates that more output is available than is
    /// included in the current response. Use this value in the `NextToken` request
    /// parameter
    /// in a subsequent call to the operation to get the next part of the output.
    /// You should repeat this
    /// until the `NextToken` response element comes back as `null`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_identifiers = "GroupIdentifiers",
        .groups = "Groups",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGroupsInput, options: CallOptions) !ListGroupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resource-groups", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-groups", "Resource Groups", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/groups-list";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListGroupsOutput {
    var result: ListGroupsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListGroupsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
