const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListAccessGrantsLocationsEntry = @import("list_access_grants_locations_entry.zig").ListAccessGrantsLocationsEntry;
const serde = @import("serde.zig");

pub const ListAccessGrantsLocationsInput = struct {
    /// The Amazon Web Services account ID of the S3 Access Grants instance.
    account_id: []const u8,

    /// The S3 path to the location that you are registering. The location scope can
    /// be the default S3 location `s3://`, the S3 path to a bucket `s3://`, or the
    /// S3 path to a bucket and prefix `s3:///`. A prefix in S3 is a string of
    /// characters at the beginning of an object key name used to organize the
    /// objects that you store in your S3 buckets. For example, object key names
    /// that start with the `engineering/` prefix or object key names that start
    /// with the `marketing/campaigns/` prefix.
    location_scope: ?[]const u8 = null,

    /// The maximum number of access grants that you would like returned in the
    /// `List Access Grants` response. If the results include the pagination token
    /// `NextToken`, make another call using the `NextToken` to determine if there
    /// are more results.
    max_results: ?i32 = null,

    /// A pagination token to request the next page of results. Pass this value into
    /// a subsequent `List Access Grants Locations` request in order to retrieve the
    /// next page of results.
    next_token: ?[]const u8 = null,
};

pub const ListAccessGrantsLocationsOutput = struct {
    /// A container for a list of registered locations in an S3 Access Grants
    /// instance.
    access_grants_locations_list: ?[]const ListAccessGrantsLocationsEntry = null,

    /// A pagination token to request the next page of results. Pass this value into
    /// a subsequent `List Access Grants Locations` request in order to retrieve the
    /// next page of results.
    next_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAccessGrantsLocationsInput, options: CallOptions) !ListAccessGrantsLocationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAccessGrantsLocationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v20180820/accessgrantsinstance/locations";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.location_scope) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "locationscope=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAccessGrantsLocationsOutput {
    var result: ListAccessGrantsLocationsOutput = .{};
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
                if (std.mem.eql(u8, e.local, "AccessGrantsLocationsList")) {
                    result.access_grants_locations_list = try serde.deserializeAccessGrantsLocationsList(allocator, &reader, "AccessGrantsLocation");
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
