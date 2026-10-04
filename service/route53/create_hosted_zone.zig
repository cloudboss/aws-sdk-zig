const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HostedZoneConfig = @import("hosted_zone_config.zig").HostedZoneConfig;
const VPC = @import("vpc.zig").VPC;
const ChangeInfo = @import("change_info.zig").ChangeInfo;
const DelegationSet = @import("delegation_set.zig").DelegationSet;
const HostedZone = @import("hosted_zone.zig").HostedZone;
const serde = @import("serde.zig");

pub const CreateHostedZoneInput = struct {
    /// A unique string that identifies the request and that allows failed
    /// `CreateHostedZone` requests to be retried without the risk of executing
    /// the operation twice. You must use a unique `CallerReference` string every
    /// time you submit a `CreateHostedZone` request. `CallerReference`
    /// can be any unique string, for example, a date/time stamp.
    caller_reference: []const u8,

    /// If you want to associate a reusable delegation set with this hosted zone,
    /// the ID that
    /// Amazon Route 53 assigned to the reusable delegation set when you created it.
    /// For more information about reusable delegation sets, see
    /// [CreateReusableDelegationSet](https://docs.aws.amazon.com/Route53/latest/APIReference/API_CreateReusableDelegationSet.html).
    ///
    /// If you are using a reusable delegation set to create a public hosted zone
    /// for a subdomain,
    /// make sure that the parent hosted zone doesn't use one or more of the same
    /// name servers.
    /// If you have overlapping nameservers, the operation will cause a
    /// `ConflictingDomainsExist` error.
    delegation_set_id: ?[]const u8 = null,

    /// (Optional) A complex type that contains the following optional values:
    ///
    /// * For public and private hosted zones, an optional comment
    ///
    /// * For private hosted zones, an optional `PrivateZone` element
    ///
    /// If you don't specify a comment or the `PrivateZone` element, omit
    /// `HostedZoneConfig` and the other elements.
    hosted_zone_config: ?HostedZoneConfig = null,

    /// The name of the domain. Specify a fully qualified domain name, for example,
    /// *www.example.com*. The trailing dot is optional; Amazon Route 53 assumes
    /// that the domain name is fully qualified. This means that
    /// Route 53 treats *www.example.com* (without a trailing
    /// dot) and *www.example.com.* (with a trailing dot) as
    /// identical.
    ///
    /// If you're creating a public hosted zone, this is the name you have
    /// registered with
    /// your DNS registrar. If your domain name is registered with a registrar other
    /// than
    /// Route 53, change the name servers for your domain to the set of
    /// `NameServers` that `CreateHostedZone` returns in
    /// `DelegationSet`.
    name: []const u8,

    /// (Private hosted zones only) A complex type that contains information about
    /// the Amazon
    /// VPC that you're associating with this hosted zone.
    ///
    /// You can specify only one Amazon VPC when you create a private hosted zone.
    /// If you are
    /// associating a VPC with a hosted zone with this request, the paramaters
    /// `VPCId` and `VPCRegion` are also required.
    ///
    /// To associate additional Amazon VPCs with the hosted zone, use
    /// [AssociateVPCWithHostedZone](https://docs.aws.amazon.com/Route53/latest/APIReference/API_AssociateVPCWithHostedZone.html) after you create a hosted zone.
    vpc: ?VPC = null,
};

pub const CreateHostedZoneOutput = struct {
    /// A complex type that contains information about the `CreateHostedZone`
    /// request.
    change_info: ?ChangeInfo = null,

    /// A complex type that describes the name servers for this hosted zone.
    delegation_set: ?DelegationSet = null,

    /// A complex type that contains general information about the hosted zone.
    hosted_zone: ?HostedZone = null,

    /// The unique URL representing the new hosted zone.
    location: []const u8,

    /// A complex type that contains information about an Amazon VPC that you
    /// associated with
    /// this hosted zone.
    vpc: ?VPC = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHostedZoneInput, options: CallOptions) !CreateHostedZoneOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHostedZoneInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/hostedzone";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateHostedZoneRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    try body_buf.appendSlice(allocator, "<CallerReference>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.caller_reference);
    try body_buf.appendSlice(allocator, "</CallerReference>");
    if (input.delegation_set_id) |v| {
        try body_buf.appendSlice(allocator, "<DelegationSetId>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</DelegationSetId>");
    }
    if (input.hosted_zone_config) |v| {
        try body_buf.appendSlice(allocator, "<HostedZoneConfig>");
        try serde.serializeHostedZoneConfig(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</HostedZoneConfig>");
    }
    try body_buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.name);
    try body_buf.appendSlice(allocator, "</Name>");
    if (input.vpc) |v| {
        try body_buf.appendSlice(allocator, "<VPC>");
        try serde.serializeVPC(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</VPC>");
    }
    try body_buf.appendSlice(allocator, "</CreateHostedZoneRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHostedZoneOutput {
    var result: CreateHostedZoneOutput = undefined;
    result.vpc = null;
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
                if (std.mem.eql(u8, e.local, "ChangeInfo")) {
                    result.change_info = try serde.deserializeChangeInfo(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "DelegationSet")) {
                    result.delegation_set = try serde.deserializeDelegationSet(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "HostedZone")) {
                    result.hosted_zone = try serde.deserializeHostedZone(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "VPC")) {
                    result.vpc = try serde.deserializeVPC(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }

    return result;
}
