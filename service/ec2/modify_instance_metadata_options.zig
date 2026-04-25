const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceMetadataEndpointState = @import("instance_metadata_endpoint_state.zig").InstanceMetadataEndpointState;
const InstanceMetadataProtocolState = @import("instance_metadata_protocol_state.zig").InstanceMetadataProtocolState;
const HttpTokensState = @import("http_tokens_state.zig").HttpTokensState;
const InstanceMetadataTagsState = @import("instance_metadata_tags_state.zig").InstanceMetadataTagsState;
const InstanceMetadataOptionsResponse = @import("instance_metadata_options_response.zig").InstanceMetadataOptionsResponse;
const serde = @import("serde.zig");

pub const ModifyInstanceMetadataOptionsInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Enables or disables the HTTP metadata endpoint on your instances. If this
    /// parameter is
    /// not specified, the existing state is maintained.
    ///
    /// If you specify a value of `disabled`, you cannot access your instance
    /// metadata.
    http_endpoint: ?InstanceMetadataEndpointState = null,

    /// Enables or disables the IPv6 endpoint for the instance metadata service.
    /// Applies only if you enabled the HTTP metadata endpoint.
    http_protocol_ipv_6: ?InstanceMetadataProtocolState = null,

    /// The desired HTTP PUT response hop limit for instance metadata requests. The
    /// larger the
    /// number, the further instance metadata requests can travel. If no parameter
    /// is specified,
    /// the existing state is maintained.
    ///
    /// Possible values: Integers from 1 to 64
    http_put_response_hop_limit: ?i32 = null,

    /// Indicates whether IMDSv2 is required.
    ///
    /// * `optional` - IMDSv2 is optional. You can choose whether to send a
    /// session token in your instance metadata retrieval requests. If you retrieve
    /// IAM role credentials without a session token, you receive the IMDSv1 role
    /// credentials. If you retrieve IAM role credentials using a valid session
    /// token,
    /// you receive the IMDSv2 role credentials.
    ///
    /// * `required` - IMDSv2 is required. You must send a session token
    /// in your instance metadata retrieval requests. With this option, retrieving
    /// the
    /// IAM role credentials always returns IMDSv2 credentials; IMDSv1 credentials
    /// are
    /// not available.
    ///
    /// Default:
    ///
    /// * If the value of `ImdsSupport` for the Amazon Machine Image (AMI)
    /// for your instance is `v2.0` and the account level default is set to
    /// `no-preference`, the default is `required`.
    ///
    /// * If the value of `ImdsSupport` for the Amazon Machine Image (AMI)
    /// for your instance is `v2.0`, but the account level default is set to
    /// `V1 or V2`, the default is `optional`.
    ///
    /// The default value can also be affected by other combinations of parameters.
    /// For more
    /// information, see [Order of precedence for instance metadata
    /// options](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-options.html#instance-metadata-options-order-of-precedence) in the
    /// *Amazon EC2 User Guide*.
    http_tokens: ?HttpTokensState = null,

    /// The ID of the instance.
    instance_id: []const u8,

    /// Set to `enabled` to allow access to instance tags from the instance
    /// metadata. Set to `disabled` to turn off access to instance tags from the
    /// instance metadata. For more information, see [View tags for your EC2
    /// instances using instance
    /// metadata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/work-with-tags-in-IMDS.html).
    instance_metadata_tags: ?InstanceMetadataTagsState = null,
};

pub const ModifyInstanceMetadataOptionsOutput = struct {
    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// The metadata options for the instance.
    instance_metadata_options: ?InstanceMetadataOptionsResponse = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyInstanceMetadataOptionsInput, options: CallOptions) !ModifyInstanceMetadataOptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyInstanceMetadataOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyInstanceMetadataOptions&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.http_endpoint) |v| {
        try body_buf.appendSlice(allocator, "&HttpEndpoint=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.http_protocol_ipv_6) |v| {
        try body_buf.appendSlice(allocator, "&HttpProtocolIpv6=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.http_put_response_hop_limit) |v| {
        try body_buf.appendSlice(allocator, "&HttpPutResponseHopLimit=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.http_tokens) |v| {
        try body_buf.appendSlice(allocator, "&HttpTokens=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&InstanceId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.instance_id);
    if (input.instance_metadata_tags) |v| {
        try body_buf.appendSlice(allocator, "&InstanceMetadataTags=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyInstanceMetadataOptionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyInstanceMetadataOptionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "instanceId")) {
                    result.instance_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "instanceMetadataOptions")) {
                    result.instance_metadata_options = try serde.deserializeInstanceMetadataOptionsResponse(allocator, &reader);
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
