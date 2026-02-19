const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
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
    /// instance metadata. For more information, see [Work with
    /// instance tags using the instance
    /// metadata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#work-with-tags-in-IMDS).
    instance_metadata_tags: ?InstanceMetadataTagsState = null,
};

pub const ModifyInstanceMetadataOptionsOutput = struct {
    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// The metadata options for the instance.
    instance_metadata_options: ?InstanceMetadataOptionsResponse = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyInstanceMetadataOptionsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyInstanceMetadataOptionsInput, options: Options) !ModifyInstanceMetadataOptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyInstanceMetadataOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyInstanceMetadataOptions&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.http_endpoint) |v| {
        try body_buf.appendSlice(alloc, "&HttpEndpoint=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.http_protocol_ipv_6) |v| {
        try body_buf.appendSlice(alloc, "&HttpProtocolIpv6=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.http_put_response_hop_limit) |v| {
        try body_buf.appendSlice(alloc, "&HttpPutResponseHopLimit=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.http_tokens) |v| {
        try body_buf.appendSlice(alloc, "&HttpTokens=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(alloc, "&InstanceId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.instance_id);
    if (input.instance_metadata_tags) |v| {
        try body_buf.appendSlice(alloc, "&InstanceMetadataTags=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyInstanceMetadataOptionsOutput {
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
                    result.instance_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "instanceMetadataOptions")) {
                    result.instance_metadata_options = try serde.deserializeInstanceMetadataOptionsResponse(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
