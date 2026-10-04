const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PhoneNumberCountryCode = @import("phone_number_country_code.zig").PhoneNumberCountryCode;
const PhoneNumberType = @import("phone_number_type.zig").PhoneNumberType;
const ListPhoneNumbersSummary = @import("list_phone_numbers_summary.zig").ListPhoneNumbersSummary;

pub const ListPhoneNumbersV2Input = struct {
    /// The identifier of the Connect Customer instance that phone numbers are
    /// claimed to. You
    /// can [find the
    /// instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance. If both `TargetArn` and `InstanceId` are not provided, this API lists
    /// numbers claimed to all the Connect Customer instances belonging to your
    /// account in the same Amazon Web Services Region as the request.
    instance_id: ?[]const u8 = null,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous
    /// response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The ISO country code.
    phone_number_country_codes: ?[]const PhoneNumberCountryCode = null,

    /// The prefix of the phone number. If provided, it must contain `+` as part of
    /// the country code.
    phone_number_prefix: ?[]const u8 = null,

    /// The type of phone number.
    phone_number_types: ?[]const PhoneNumberType = null,

    /// The Amazon Resource Name (ARN) for Connect Customer instances or traffic
    /// distribution groups that phone number inbound traffic is routed through. If
    /// both `TargetArn` and `InstanceId` input are not provided, this API lists
    /// numbers claimed to all the Connect Customer instances belonging to your
    /// account in the same Amazon Web Services Region as the request.
    target_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .phone_number_country_codes = "PhoneNumberCountryCodes",
        .phone_number_prefix = "PhoneNumberPrefix",
        .phone_number_types = "PhoneNumberTypes",
        .target_arn = "TargetArn",
    };
};

pub const ListPhoneNumbersV2Output = struct {
    /// Information about phone numbers that have been claimed to your Connect
    /// Customer instances or traffic distribution groups.
    list_phone_numbers_summary_list: ?[]const ListPhoneNumbersSummary = null,

    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .list_phone_numbers_summary_list = "ListPhoneNumbersSummaryList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPhoneNumbersV2Input, options: CallOptions) !ListPhoneNumbersV2Output {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPhoneNumbersV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/phone-number/list";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.instance_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InstanceId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.phone_number_country_codes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PhoneNumberCountryCodes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.phone_number_prefix) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PhoneNumberPrefix\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.phone_number_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PhoneNumberTypes\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPhoneNumbersV2Output {
    const result: ListPhoneNumbersV2Output = try aws.json.parseJsonObject(
        ListPhoneNumbersV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
