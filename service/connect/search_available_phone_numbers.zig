const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PhoneNumberCountryCode = @import("phone_number_country_code.zig").PhoneNumberCountryCode;
const PhoneNumberType = @import("phone_number_type.zig").PhoneNumberType;
const AvailableNumberSummary = @import("available_number_summary.zig").AvailableNumberSummary;

pub const SearchAvailablePhoneNumbersInput = struct {
    /// The identifier of the Connect Customer instance that phone numbers are
    /// claimed to. You
    /// can [find the
    /// instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance. You must enter `InstanceId` or `TargetArn`.
    instance_id: ?[]const u8 = null,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous
    /// response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The ISO country code.
    phone_number_country_code: PhoneNumberCountryCode,

    /// The prefix of the phone number. If provided, it must contain `+` as part of
    /// the country code.
    phone_number_prefix: ?[]const u8 = null,

    /// The type of phone number.
    phone_number_type: PhoneNumberType,

    /// The Amazon Resource Name (ARN) for Connect Customer instances or traffic
    /// distribution groups that phone number inbound traffic is routed through. You
    /// must enter `InstanceId` or `TargetArn`.
    target_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .phone_number_country_code = "PhoneNumberCountryCode",
        .phone_number_prefix = "PhoneNumberPrefix",
        .phone_number_type = "PhoneNumberType",
        .target_arn = "TargetArn",
    };
};

pub const SearchAvailablePhoneNumbersOutput = struct {
    /// A list of available phone numbers that you can claim to your Connect
    /// Customer instance or traffic distribution group.
    available_numbers_list: ?[]const AvailableNumberSummary = null,

    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .available_numbers_list = "AvailableNumbersList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchAvailablePhoneNumbersInput, options: CallOptions) !SearchAvailablePhoneNumbersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchAvailablePhoneNumbersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/phone-number/search-available";

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PhoneNumberCountryCode\":");
    try aws.json.writeValue(@TypeOf(input.phone_number_country_code), input.phone_number_country_code, allocator, &body_buf);
    has_prev = true;
    if (input.phone_number_prefix) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PhoneNumberPrefix\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PhoneNumberType\":");
    try aws.json.writeValue(@TypeOf(input.phone_number_type), input.phone_number_type, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchAvailablePhoneNumbersOutput {
    const result: SearchAvailablePhoneNumbersOutput = try aws.json.parseJsonObject(
        SearchAvailablePhoneNumbersOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
