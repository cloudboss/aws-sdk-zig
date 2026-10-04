const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectorType = @import("connector_type.zig").ConnectorType;
const ConnectorProfile = @import("connector_profile.zig").ConnectorProfile;

pub const DescribeConnectorProfilesInput = struct {
    /// The name of the connector. The name is unique for each
    /// `ConnectorRegistration`
    /// in your Amazon Web Services account. Only needed if calling for
    /// CUSTOMCONNECTOR connector
    /// type/.
    connector_label: ?[]const u8 = null,

    /// The name of the connector profile. The name is unique for each
    /// `ConnectorProfile` in the Amazon Web Services account.
    connector_profile_names: ?[]const []const u8 = null,

    /// The type of connector, such as Salesforce, Amplitude, and so on.
    connector_type: ?ConnectorType = null,

    /// Specifies the maximum number of items that should be returned in the result
    /// set. The
    /// default for `maxResults` is 20 (for all paginated API operations).
    max_results: ?i32 = null,

    /// The pagination token for the next page of data.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_label = "connectorLabel",
        .connector_profile_names = "connectorProfileNames",
        .connector_type = "connectorType",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const DescribeConnectorProfilesOutput = struct {
    /// Returns information about the connector profiles associated with the flow.
    connector_profile_details: ?[]const ConnectorProfile = null,

    /// The pagination token for the next page of data. If `nextToken=null`, this
    /// means that all records have been fetched.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_profile_details = "connectorProfileDetails",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConnectorProfilesInput, options: CallOptions) !DescribeConnectorProfilesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appflow", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConnectorProfilesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appflow", "Appflow", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/describe-connector-profiles";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.connector_label) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorLabel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_profile_names) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorProfileNames\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConnectorProfilesOutput {
    const result: DescribeConnectorProfilesOutput = try aws.json.parseJsonObject(
        DescribeConnectorProfilesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
