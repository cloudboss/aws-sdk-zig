const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountPreferences = @import("account_preferences.zig").AccountPreferences;

pub const UpdateAccountPreferencesInput = struct {
    /// Turns on training data collection.
    ///
    /// This helps improve the AWS Chatbot experience by allowing AWS Chatbot to
    /// store and use your customer information, such as AWS Chatbot configurations,
    /// notifications, user inputs, AWS Chatbot generated responses, and interaction
    /// data. This data helps us to continuously improve and develop Artificial
    /// Intelligence (AI) technologies. Your data is not shared with any third
    /// parties and is protected using sophisticated controls to prevent
    /// unauthorized access and misuse. AWS Chatbot does not store or use
    /// interactions in chat channels with Amazon Q for training AI technologies for
    /// AWS Chatbot.
    training_data_collection_enabled: ?bool = null,

    /// Enables use of a user role requirement in your chat configuration.
    user_authorization_required: ?bool = null,

    pub const json_field_names = .{
        .training_data_collection_enabled = "TrainingDataCollectionEnabled",
        .user_authorization_required = "UserAuthorizationRequired",
    };
};

pub const UpdateAccountPreferencesOutput = struct {
    /// Preferences related to AWS Chatbot usage in the calling AWS account.
    account_preferences: ?AccountPreferences = null,

    pub const json_field_names = .{
        .account_preferences = "AccountPreferences",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccountPreferencesInput, options: CallOptions) !UpdateAccountPreferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chatbot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccountPreferencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chatbot", "chatbot", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/update-account-preferences";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.training_data_collection_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TrainingDataCollectionEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.user_authorization_required) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UserAuthorizationRequired\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccountPreferencesOutput {
    const result: UpdateAccountPreferencesOutput = try aws.json.parseJsonObject(
        UpdateAccountPreferencesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
