const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GeoLocationDetails = @import("geo_location_details.zig").GeoLocationDetails;
const serde = @import("serde.zig");

pub const GetGeoLocationInput = struct {
    /// For geolocation resource record sets, a two-letter abbreviation that
    /// identifies a
    /// continent. Amazon Route 53 supports the following continent codes:
    ///
    /// * **AF**: Africa
    ///
    /// * **AN**: Antarctica
    ///
    /// * **AS**: Asia
    ///
    /// * **EU**: Europe
    ///
    /// * **OC**: Oceania
    ///
    /// * **NA**: North America
    ///
    /// * **SA**: South America
    continent_code: ?[]const u8 = null,

    /// Amazon Route 53 uses the two-letter country codes that are specified in [ISO
    /// standard 3166-1
    /// alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2).
    ///
    /// Route 53 also supports the country code **UA** for
    /// Ukraine.
    country_code: ?[]const u8 = null,

    /// The code for the subdivision, such as a particular state within the United
    /// States. For
    /// a list of US state abbreviations, see [Appendix B: Two–Letter State and
    /// Possession Abbreviations](https://pe.usps.com/text/pub28/28apb.htm) on the
    /// United States Postal Service website. For a
    /// list of all supported subdivision codes, use the
    /// [ListGeoLocations](https://docs.aws.amazon.com/Route53/latest/APIReference/API_ListGeoLocations.html)
    /// API.
    subdivision_code: ?[]const u8 = null,
};

pub const GetGeoLocationOutput = struct {
    /// A complex type that contains the codes and full continent, country, and
    /// subdivision
    /// names for the specified geolocation code.
    geo_location_details: ?GeoLocationDetails = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGeoLocationInput, options: CallOptions) !GetGeoLocationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGeoLocationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/geolocation";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.continent_code) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "continentcode=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.country_code) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "countrycode=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.subdivision_code) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "subdivisioncode=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGeoLocationOutput {
    var result: GetGeoLocationOutput = undefined;
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
                if (std.mem.eql(u8, e.local, "GeoLocationDetails")) {
                    result.geo_location_details = try serde.deserializeGeoLocationDetails(allocator, &reader);
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
