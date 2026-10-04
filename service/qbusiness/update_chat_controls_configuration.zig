const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BlockedPhrasesConfigurationUpdate = @import("blocked_phrases_configuration_update.zig").BlockedPhrasesConfigurationUpdate;
const CreatorModeConfiguration = @import("creator_mode_configuration.zig").CreatorModeConfiguration;
const HallucinationReductionConfiguration = @import("hallucination_reduction_configuration.zig").HallucinationReductionConfiguration;
const OrchestrationConfiguration = @import("orchestration_configuration.zig").OrchestrationConfiguration;
const ResponseScope = @import("response_scope.zig").ResponseScope;
const TopicConfiguration = @import("topic_configuration.zig").TopicConfiguration;

pub const UpdateChatControlsConfigurationInput = struct {
    /// The identifier of the application for which the chat controls are
    /// configured.
    application_id: []const u8,

    /// The phrases blocked from chat by your chat control configuration.
    blocked_phrases_configuration_update: ?BlockedPhrasesConfigurationUpdate = null,

    /// A token that you provide to identify the request to update a Amazon Q
    /// Business application chat configuration.
    client_token: ?[]const u8 = null,

    /// The configuration details for `CREATOR_MODE`.
    creator_mode_configuration: ?CreatorModeConfiguration = null,

    /// The hallucination reduction settings for your application.
    hallucination_reduction_configuration: ?HallucinationReductionConfiguration = null,

    /// The chat response orchestration settings for your application.
    orchestration_configuration: ?OrchestrationConfiguration = null,

    /// The response scope configured for your application. This determines whether
    /// your application uses its retrieval augmented generation (RAG) system to
    /// generate answers only from your enterprise data, or also uses the large
    /// language models (LLM) knowledge to respons to end user questions in chat.
    response_scope: ?ResponseScope = null,

    /// The configured topic specific chat controls you want to update.
    topic_configurations_to_create_or_update: ?[]const TopicConfiguration = null,

    /// The configured topic specific chat controls you want to delete.
    topic_configurations_to_delete: ?[]const TopicConfiguration = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .blocked_phrases_configuration_update = "blockedPhrasesConfigurationUpdate",
        .client_token = "clientToken",
        .creator_mode_configuration = "creatorModeConfiguration",
        .hallucination_reduction_configuration = "hallucinationReductionConfiguration",
        .orchestration_configuration = "orchestrationConfiguration",
        .response_scope = "responseScope",
        .topic_configurations_to_create_or_update = "topicConfigurationsToCreateOrUpdate",
        .topic_configurations_to_delete = "topicConfigurationsToDelete",
    };
};

pub const UpdateChatControlsConfigurationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateChatControlsConfigurationInput, options: CallOptions) !UpdateChatControlsConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateChatControlsConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/chatcontrols");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.blocked_phrases_configuration_update) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"blockedPhrasesConfigurationUpdate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.creator_mode_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"creatorModeConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.hallucination_reduction_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"hallucinationReductionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.orchestration_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"orchestrationConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.response_scope) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"responseScope\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.topic_configurations_to_create_or_update) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"topicConfigurationsToCreateOrUpdate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.topic_configurations_to_delete) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"topicConfigurationsToDelete\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateChatControlsConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateChatControlsConfigurationOutput = .{};

    return result;
}
