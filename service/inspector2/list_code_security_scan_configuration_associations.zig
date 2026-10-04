const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CodeSecurityScanConfigurationAssociationSummary = @import("code_security_scan_configuration_association_summary.zig").CodeSecurityScanConfigurationAssociationSummary;

pub const ListCodeSecurityScanConfigurationAssociationsInput = struct {
    /// The maximum number of results to return in the response. If your request
    /// would return
    /// more than the maximum the response will return a `nextToken` value, use this
    /// value when you call the action again to get the remaining results.
    max_results: ?i32 = null,

    /// A token to use for paginating results that are returned in the response. Set
    /// the value
    /// of this parameter to null for the first request to a list action. For
    /// subsequent calls, use
    /// the `NextToken` value returned from the previous request to continue listing
    /// results after the first page.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the scan configuration to list
    /// associations
    /// for.
    scan_configuration_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .scan_configuration_arn = "scanConfigurationArn",
    };
};

pub const ListCodeSecurityScanConfigurationAssociationsOutput = struct {
    /// A list of associations between code repositories and scan configurations.
    associations: ?[]const CodeSecurityScanConfigurationAssociationSummary = null,

    /// A token to use for paginating results that are returned in the response. Set
    /// the value
    /// of this parameter to null for the first request to a list action. For
    /// subsequent calls, use
    /// the `NextToken` value returned from the previous request to continue listing
    /// results after the first page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .associations = "associations",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCodeSecurityScanConfigurationAssociationsInput, options: CallOptions) !ListCodeSecurityScanConfigurationAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCodeSecurityScanConfigurationAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/codesecurity/scan-configuration/associations/list";

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

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scanConfigurationArn\":");
    try aws.json.writeValue(@TypeOf(input.scan_configuration_arn), input.scan_configuration_arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCodeSecurityScanConfigurationAssociationsOutput {
    const result: ListCodeSecurityScanConfigurationAssociationsOutput = try aws.json.parseJsonObject(
        ListCodeSecurityScanConfigurationAssociationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
