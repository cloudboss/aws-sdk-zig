const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PayerResponsibilityType = @import("payer_responsibility_type.zig").PayerResponsibilityType;
const PayerResponsibilityScope = @import("payer_responsibility_scope.zig").PayerResponsibilityScope;
const PayerResponsibilityEntry = @import("payer_responsibility_entry.zig").PayerResponsibilityEntry;
const serde = @import("serde.zig");

pub const ModifyVpcEndpointPayerResponsibilityInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The Amazon Web Services account to which the usage of VPC endpoint is
    /// charged.
    payer_responsibility: PayerResponsibilityType,

    /// The scope of usage/charges for which the billing account is being modified.
    scope: PayerResponsibilityScope,

    /// The ID of the VPC endpoint service.
    service_id: ?[]const u8 = null,

    /// The ID of the VPC endpoint.
    vpc_endpoint_id: []const u8,
};

pub const ModifyVpcEndpointPayerResponsibilityOutput = struct {
    /// The payer responsibility settings for the VPC endpoint.
    payer_responsibilities: ?[]const PayerResponsibilityEntry = null,

    /// The ID of the VPC endpoint.
    vpc_endpoint_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyVpcEndpointPayerResponsibilityInput, options: CallOptions) !ModifyVpcEndpointPayerResponsibilityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ec2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyVpcEndpointPayerResponsibilityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyVpcEndpointPayerResponsibility&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&PayerResponsibility=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.payer_responsibility.wireName());
    try body_buf.appendSlice(allocator, "&Scope=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.scope.wireName());
    if (input.service_id) |v| {
        try body_buf.appendSlice(allocator, "&ServiceId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&VpcEndpointId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.vpc_endpoint_id);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyVpcEndpointPayerResponsibilityOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyVpcEndpointPayerResponsibilityOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "payerResponsibilitySet")) {
                    result.payer_responsibilities = try serde.deserializePayerResponsibilitySet(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "vpcEndpointId")) {
                    result.vpc_endpoint_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
