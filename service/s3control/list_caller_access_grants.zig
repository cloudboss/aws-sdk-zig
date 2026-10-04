const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListCallerAccessGrantsEntry = @import("list_caller_access_grants_entry.zig").ListCallerAccessGrantsEntry;
const serde = @import("serde.zig");

pub const ListCallerAccessGrantsInput = struct {
    /// The Amazon Web Services account ID of the S3 Access Grants instance.
    account_id: []const u8,

    /// If this optional parameter is passed in the request, a filter is applied to
    /// the results. The results will include only the access grants for the
    /// caller's Identity Center application or for any other applications (`ALL`).
    allowed_by_application: ?bool = null,

    /// The S3 path of the data that you would like to access. Must start with
    /// `s3://`. You can optionally pass only the beginning characters of a path,
    /// and S3 Access Grants will search for all applicable grants for the path
    /// fragment.
    grant_scope: ?[]const u8 = null,

    /// The maximum number of access grants that you would like returned in the
    /// `List Caller Access Grants` response. If the results include the pagination
    /// token `NextToken`, make another call using the `NextToken` to determine if
    /// there are more results.
    max_results: ?i32 = null,

    /// A pagination token to request the next page of results. Pass this value into
    /// a subsequent `List Caller Access Grants` request in order to retrieve the
    /// next page of results.
    next_token: ?[]const u8 = null,
};

pub const ListCallerAccessGrantsOutput = struct {
    /// A list of the caller's access grants that were created using S3 Access
    /// Grants and that grant the caller access to the S3 data of the Amazon Web
    /// Services account ID that was specified in the request.
    caller_access_grants_list: ?[]const ListCallerAccessGrantsEntry = null,

    /// A pagination token that you can use to request the next page of results.
    /// Pass this value into a subsequent `List Caller Access Grants` request in
    /// order to retrieve the next page of results.
    next_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCallerAccessGrantsInput, options: CallOptions) !ListCallerAccessGrantsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCallerAccessGrantsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v20180820/accessgrantsinstance/caller/grants";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.allowed_by_application) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "allowedByApplication=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.grant_scope) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "grantscope=");
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
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
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
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCallerAccessGrantsOutput {
    var result: ListCallerAccessGrantsOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerAccessGrantsList")) {
                    result.caller_access_grants_list = try serde.deserializeCallerAccessGrantsList(allocator, &reader, "AccessGrant");
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}
