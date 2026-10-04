const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GeoLocationDetails = @import("geo_location_details.zig").GeoLocationDetails;
const serde = @import("serde.zig");

pub const ListGeoLocationsInput = struct {
    /// (Optional) The maximum number of geolocations to be included in the response
    /// body for this
    /// request. If more than `maxitems` geolocations remain to be listed, then the
    /// value of the `IsTruncated` element in the response is
    /// `true`.
    max_items: ?i32 = null,

    /// The code for the continent with which you want to start listing locations
    /// that Amazon
    /// Route 53 supports for geolocation. If Route 53 has already returned a page
    /// or more of
    /// results, if `IsTruncated` is true, and if `NextContinentCode` from
    /// the previous response has a value, enter that value in `startcontinentcode`
    /// to return the next page of results.
    ///
    /// Include `startcontinentcode` only if you want to list continents. Don't
    /// include `startcontinentcode` when you're listing countries or countries with
    /// their subdivisions.
    start_continent_code: ?[]const u8 = null,

    /// The code for the country with which you want to start listing locations that
    /// Amazon
    /// Route 53 supports for geolocation. If Route 53 has already returned a page
    /// or more of
    /// results, if `IsTruncated` is `true`, and if
    /// `NextCountryCode` from the previous response has a value, enter that
    /// value in `startcountrycode` to return the next page of results.
    start_country_code: ?[]const u8 = null,

    /// The code for the state of the United States with which you want to start
    /// listing
    /// locations that Amazon Route 53 supports for geolocation. If Route 53 has
    /// already
    /// returned a page or more of results, if `IsTruncated` is `true`,
    /// and if `NextSubdivisionCode` from the previous response has a value, enter
    /// that value in `startsubdivisioncode` to return the next page of
    /// results.
    ///
    /// To list subdivisions (U.S. states), you must include both
    /// `startcountrycode` and `startsubdivisioncode`.
    start_subdivision_code: ?[]const u8 = null,
};

pub const ListGeoLocationsOutput = struct {
    /// A complex type that contains one `GeoLocationDetails` element for each
    /// location that Amazon Route 53 supports for geolocation.
    geo_location_details_list: ?[]const GeoLocationDetails = null,

    /// A value that indicates whether more locations remain to be listed after the
    /// last
    /// location in this response. If so, the value of `IsTruncated` is
    /// `true`. To get more values, submit another request and include the values
    /// of `NextContinentCode`, `NextCountryCode`, and
    /// `NextSubdivisionCode` in the `startcontinentcode`,
    /// `startcountrycode`, and `startsubdivisioncode`, as
    /// applicable.
    is_truncated: ?bool = null,

    /// The value that you specified for `MaxItems` in the request.
    max_items: i32,

    /// If `IsTruncated` is `true`, you can make a follow-up request to
    /// display more locations. Enter the value of `NextContinentCode` in the
    /// `startcontinentcode` parameter in another `ListGeoLocations`
    /// request.
    next_continent_code: ?[]const u8 = null,

    /// If `IsTruncated` is `true`, you can make a follow-up request to
    /// display more locations. Enter the value of `NextCountryCode` in the
    /// `startcountrycode` parameter in another `ListGeoLocations`
    /// request.
    next_country_code: ?[]const u8 = null,

    /// If `IsTruncated` is `true`, you can make a follow-up request to
    /// display more locations. Enter the value of `NextSubdivisionCode` in the
    /// `startsubdivisioncode` parameter in another `ListGeoLocations`
    /// request.
    next_subdivision_code: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGeoLocationsInput, options: CallOptions) !ListGeoLocationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListGeoLocationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/geolocations";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxitems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.start_continent_code) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startcontinentcode=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.start_country_code) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startcountrycode=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.start_subdivision_code) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startsubdivisioncode=");
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListGeoLocationsOutput {
    var result: ListGeoLocationsOutput = undefined;
    result.next_continent_code = null;
    result.next_country_code = null;
    result.next_subdivision_code = null;
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
                if (std.mem.eql(u8, e.local, "GeoLocationDetailsList")) {
                    result.geo_location_details_list = try serde.deserializeGeoLocationDetailsList(allocator, &reader, "GeoLocationDetails");
                } else if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextContinentCode")) {
                    result.next_continent_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NextCountryCode")) {
                    result.next_country_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NextSubdivisionCode")) {
                    result.next_subdivision_code = try allocator.dupe(u8, try reader.readElementText());
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
