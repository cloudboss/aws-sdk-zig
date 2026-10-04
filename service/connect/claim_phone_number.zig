const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ClaimPhoneNumberInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    ///
    /// Pattern: `^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$`
    client_token: ?[]const u8 = null,

    /// The identifier of the Connect Customer instance that phone numbers are
    /// claimed to. You
    /// can [find the
    /// instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance. You must enter `InstanceId` or `TargetArn`.
    instance_id: ?[]const u8 = null,

    /// The phone number you want to claim. Phone numbers are formatted `[+]
    /// [country code] [subscriber number
    /// including area code]`.
    phone_number: []const u8,

    /// The description of the phone number.
    phone_number_description: ?[]const u8 = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) for Connect Customer instances or traffic
    /// distribution groups that phone number inbound traffic is routed through. You
    /// must enter `InstanceId` or `TargetArn`.
    target_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .instance_id = "InstanceId",
        .phone_number = "PhoneNumber",
        .phone_number_description = "PhoneNumberDescription",
        .tags = "Tags",
        .target_arn = "TargetArn",
    };
};

pub const ClaimPhoneNumberOutput = struct {
    /// The Amazon Resource Name (ARN) of the phone number.
    phone_number_arn: ?[]const u8 = null,

    /// A unique identifier for the phone number.
    phone_number_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .phone_number_arn = "PhoneNumberArn",
        .phone_number_id = "PhoneNumberId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ClaimPhoneNumberInput, options: CallOptions) !ClaimPhoneNumberOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ClaimPhoneNumberInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/phone-number/claim";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.instance_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InstanceId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PhoneNumber\":");
    try aws.json.writeValue(@TypeOf(input.phone_number), input.phone_number, allocator, &body_buf);
    has_prev = true;
    if (input.phone_number_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PhoneNumberDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.target_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TargetArn\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ClaimPhoneNumberOutput {
    const result: ClaimPhoneNumberOutput = try aws.json.parseJsonObject(
        ClaimPhoneNumberOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
