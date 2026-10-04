const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RRType = @import("rr_type.zig").RRType;
const serde = @import("serde.zig");

pub const TestDNSAnswerInput = struct {
    /// If the resolver that you specified for resolverip supports EDNS0, specify
    /// the IPv4 or
    /// IPv6 address of a client in the applicable location, for example,
    /// `192.0.2.44` or `2001:db8:85a3::8a2e:370:7334`.
    edns0_client_subnet_ip: ?[]const u8 = null,

    /// If you specify an IP address for `edns0clientsubnetip`, you can optionally
    /// specify the number of bits of the IP address that you want the checking tool
    /// to include
    /// in the DNS query. For example, if you specify `192.0.2.44` for
    /// `edns0clientsubnetip` and `24` for
    /// `edns0clientsubnetmask`, the checking tool will simulate a request from
    /// 192.0.2.0/24. The default value is 24 bits for IPv4 addresses and 64 bits
    /// for IPv6
    /// addresses.
    ///
    /// The range of valid values depends on whether `edns0clientsubnetip` is an
    /// IPv4 or an IPv6 address:
    ///
    /// * **IPv4**: Specify a value between 0 and 32
    ///
    /// * **IPv6**: Specify a value between 0 and
    /// 128
    edns0_client_subnet_mask: ?[]const u8 = null,

    /// The ID of the hosted zone that you want Amazon Route 53 to simulate a query
    /// for.
    hosted_zone_id: []const u8,

    /// The name of the resource record set that you want Amazon Route 53 to
    /// simulate a query
    /// for.
    record_name: []const u8,

    /// The type of the resource record set.
    record_type: RRType,

    /// If you want to simulate a request from a specific DNS resolver, specify the
    /// IP address
    /// for that resolver. If you omit this value, `TestDnsAnswer` uses the IP
    /// address of a DNS resolver in the Amazon Web Services US East (N. Virginia)
    /// Region
    /// (`us-east-1`).
    resolver_ip: ?[]const u8 = null,
};

pub const TestDNSAnswerOutput = struct {
    /// The Amazon Route 53 name server used to respond to the request.
    nameserver: []const u8,

    /// The protocol that Amazon Route 53 used to respond to the request, either
    /// `UDP` or `TCP`.
    protocol: []const u8,

    /// A list that contains values that Amazon Route 53 returned for this resource
    /// record
    /// set.
    record_data: ?[]const []const u8 = null,

    /// The name of the resource record set that you submitted a request for.
    record_name: []const u8,

    /// The type of the resource record set that you submitted a request for.
    record_type: RRType,

    /// A code that indicates whether the request is valid or not. The most common
    /// response
    /// code is `NOERROR`, meaning that the request is valid. If the response is not
    /// valid, Amazon Route 53 returns a response code that describes the error. For
    /// a list of
    /// possible response codes, see [DNS
    /// RCODES](http://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6) on the IANA website.
    response_code: []const u8,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestDNSAnswerInput, options: CallOptions) !TestDNSAnswerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TestDNSAnswerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/testdnsanswer";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.edns0_client_subnet_ip) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "edns0clientsubnetip=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.edns0_client_subnet_mask) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "edns0clientsubnetmask=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "hostedzoneid=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.hosted_zone_id);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "recordname=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.record_name);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "recordtype=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.record_type.wireName());
    query_has_prev = true;
    if (input.resolver_ip) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resolverip=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestDNSAnswerOutput {
    var result: TestDNSAnswerOutput = undefined;
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
                if (std.mem.eql(u8, e.local, "Nameserver")) {
                    result.nameserver = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecordData")) {
                    result.record_data = try serde.deserializeRecordData(allocator, &reader, "RecordDataEntry");
                } else if (std.mem.eql(u8, e.local, "RecordName")) {
                    result.record_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecordType")) {
                    result.record_type = RRType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "ResponseCode")) {
                    result.response_code = try allocator.dupe(u8, try reader.readElementText());
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
