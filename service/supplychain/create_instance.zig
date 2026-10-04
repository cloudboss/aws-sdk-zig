const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Instance = @import("instance.zig").Instance;

pub const CreateInstanceInput = struct {
    /// The client token for idempotency.
    client_token: ?[]const u8 = null,

    /// The AWS Supply Chain instance description.
    instance_description: ?[]const u8 = null,

    /// The AWS Supply Chain instance name.
    instance_name: ?[]const u8 = null,

    /// The ARN (Amazon Resource Name) of the Key Management Service (KMS) key you
    /// provide for encryption. This is required if you do not want to use the
    /// Amazon Web Services owned KMS key. If you don't provide anything here, AWS
    /// Supply Chain uses the Amazon Web Services owned KMS key.
    kms_key_arn: ?[]const u8 = null,

    /// The Amazon Web Services tags of an instance to be created.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The DNS subdomain of the web app. This would be "example" in the URL
    /// "example.scn.global.on.aws". You can set this to a custom value, as long as
    /// the domain isn't already being used by someone else. The name may only
    /// include alphanumeric characters and hyphens.
    web_app_dns_domain: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .instance_description = "instanceDescription",
        .instance_name = "instanceName",
        .kms_key_arn = "kmsKeyArn",
        .tags = "tags",
        .web_app_dns_domain = "webAppDnsDomain",
    };
};

pub const CreateInstanceOutput = struct {
    /// The AWS Supply Chain instance resource data details.
    instance: ?Instance = null,

    pub const json_field_names = .{
        .instance = "instance",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInstanceInput, options: CallOptions) !CreateInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "scn", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scn", "SupplyChain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/api/instance";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.instance_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"instanceDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.instance_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"instanceName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.web_app_dns_domain) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"webAppDnsDomain\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInstanceOutput {
    const result: CreateInstanceOutput = try aws.json.parseJsonObject(
        CreateInstanceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
