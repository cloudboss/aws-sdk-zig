const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RRType = @import("rr_type.zig").RRType;
const ResourceRecordSet = @import("resource_record_set.zig").ResourceRecordSet;
const serde = @import("serde.zig");

pub const ListResourceRecordSetsInput = struct {
    /// The ID of the hosted zone that contains the resource record sets that you
    /// want to
    /// list.
    hosted_zone_id: []const u8,

    /// (Optional) The maximum number of resource records sets to include in the
    /// response body
    /// for this request. If the response includes more than `maxitems` resource
    /// record sets, the value of the `IsTruncated` element in the response is
    /// `true`, and the values of the `NextRecordName` and
    /// `NextRecordType` elements in the response identify the first resource
    /// record set in the next group of `maxitems` resource record sets.
    max_items: ?i32 = null,

    /// *Resource record sets that have a routing policy other than
    /// simple:* If results were truncated for a given DNS name and type, specify
    /// the value of `NextRecordIdentifier` from the previous response to get the
    /// next resource record set that has the current DNS name and type.
    start_record_identifier: ?[]const u8 = null,

    /// The first name in the lexicographic ordering of resource record sets that
    /// you want to
    /// list. If the specified record name doesn't exist, the results begin with the
    /// first
    /// resource record set that has a name greater than the value of `name`.
    start_record_name: ?[]const u8 = null,

    /// The type of resource record set to begin the record listing from.
    ///
    /// Valid values for basic resource record sets: `A` | `AAAA` |
    /// `CAA` | `CNAME` | `MX` | `NAPTR` |
    /// `NS` | `PTR` | `SOA` | `SPF` |
    /// `SRV` | `TXT`
    ///
    /// Values for weighted, latency, geolocation, and failover resource record
    /// sets:
    /// `A` | `AAAA` | `CAA` | `CNAME` |
    /// `MX` | `NAPTR` | `PTR` | `SPF` |
    /// `SRV` | `TXT`
    ///
    /// Values for alias resource record sets:
    ///
    /// * **API Gateway custom regional API or edge-optimized
    /// API**: A
    ///
    /// * **CloudFront distribution**: A or AAAA
    ///
    /// * **Elastic Beanstalk environment that has a regionalized
    /// subdomain**: A
    ///
    /// * **Elastic Load Balancing load balancer**: A |
    /// AAAA
    ///
    /// * **S3 bucket**: A
    ///
    /// * **VPC interface VPC endpoint**: A
    ///
    /// * **Another resource record set in this hosted
    /// zone:** The type of the resource record set that the alias
    /// references.
    ///
    /// Constraint: Specifying `type` without specifying `name` returns
    /// an `InvalidInput` error.
    start_record_type: ?RRType = null,
};

pub const ListResourceRecordSetsOutput = struct {
    /// A flag that indicates whether more resource record sets remain to be listed.
    /// If your
    /// results were truncated, you can make a follow-up pagination request by using
    /// the
    /// `NextRecordName` element.
    is_truncated: ?bool = null,

    /// The maximum number of records you requested.
    max_items: i32,

    /// *Resource record sets that have a routing policy other than
    /// simple:* If results were truncated for a given DNS name and type, the
    /// value of `SetIdentifier` for the next resource record set that has the
    /// current DNS name and type.
    ///
    /// For information about routing policies, see [Choosing a Routing
    /// Policy](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html) in the *Amazon Route 53 Developer Guide*.
    next_record_identifier: ?[]const u8 = null,

    /// If the results were truncated, the name of the next record in the list.
    ///
    /// This element is present only if `IsTruncated` is true.
    next_record_name: ?[]const u8 = null,

    /// If the results were truncated, the type of the next record in the list.
    ///
    /// This element is present only if `IsTruncated` is true.
    next_record_type: ?RRType = null,

    /// Information about multiple resource record sets.
    resource_record_sets: ?[]const ResourceRecordSet = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourceRecordSetsInput, options: CallOptions) !ListResourceRecordSetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourceRecordSetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2013-04-01/hostedzone/");
    try path_buf.appendSlice(allocator, input.hosted_zone_id);
    try path_buf.appendSlice(allocator, "/rrset");
    const path = try path_buf.toOwnedSlice(allocator);

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
    if (input.start_record_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "identifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.start_record_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "name=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.start_record_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "type=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourceRecordSetsOutput {
    var result: ListResourceRecordSetsOutput = undefined;
    result.next_record_identifier = null;
    result.next_record_name = null;
    result.next_record_type = null;
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
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextRecordIdentifier")) {
                    result.next_record_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NextRecordName")) {
                    result.next_record_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NextRecordType")) {
                    result.next_record_type = RRType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceRecordSets")) {
                    result.resource_record_sets = try serde.deserializeResourceRecordSets(allocator, &reader, "ResourceRecordSet");
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
