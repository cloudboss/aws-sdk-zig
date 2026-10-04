const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessType = @import("access_type.zig").AccessType;
const LogSourceResource = @import("log_source_resource.zig").LogSourceResource;
const AwsIdentity = @import("aws_identity.zig").AwsIdentity;
const Tag = @import("tag.zig").Tag;
const SubscriberResource = @import("subscriber_resource.zig").SubscriberResource;

pub const CreateSubscriberInput = struct {
    /// The Amazon S3 or Lake Formation access type.
    access_types: ?[]const AccessType = null,

    /// The supported Amazon Web Services services from which logs and events are
    /// collected.
    /// Security Lake supports log and event collection for natively supported
    /// Amazon Web Services services.
    sources: []const LogSourceResource,

    /// The description for your subscriber account in Security Lake.
    subscriber_description: ?[]const u8 = null,

    /// The Amazon Web Services identity used to access your data.
    subscriber_identity: AwsIdentity,

    /// The name of your Security Lake subscriber account.
    subscriber_name: []const u8,

    /// An array of objects, one for each tag to associate with the subscriber. For
    /// each tag, you must specify both a tag key and a tag value. A tag
    /// value cannot be null, but it can be an empty string.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .access_types = "accessTypes",
        .sources = "sources",
        .subscriber_description = "subscriberDescription",
        .subscriber_identity = "subscriberIdentity",
        .subscriber_name = "subscriberName",
        .tags = "tags",
    };
};

pub const CreateSubscriberOutput = struct {
    /// Retrieve information about the subscriber created using the
    /// `CreateSubscriber` API.
    subscriber: ?SubscriberResource = null,

    pub const json_field_names = .{
        .subscriber = "subscriber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSubscriberInput, options: CallOptions) !CreateSubscriberOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securitylake", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSubscriberInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securitylake", "SecurityLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/subscribers";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.access_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accessTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sources\":");
    try aws.json.writeValue(@TypeOf(input.sources), input.sources, allocator, &body_buf);
    has_prev = true;
    if (input.subscriber_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"subscriberDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"subscriberIdentity\":");
    try aws.json.writeValue(@TypeOf(input.subscriber_identity), input.subscriber_identity, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"subscriberName\":");
    try aws.json.writeValue(@TypeOf(input.subscriber_name), input.subscriber_name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSubscriberOutput {
    var result: CreateSubscriberOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSubscriberOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
