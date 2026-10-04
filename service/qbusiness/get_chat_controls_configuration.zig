const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BlockedPhrasesConfiguration = @import("blocked_phrases_configuration.zig").BlockedPhrasesConfiguration;
const AppliedCreatorModeConfiguration = @import("applied_creator_mode_configuration.zig").AppliedCreatorModeConfiguration;
const HallucinationReductionConfiguration = @import("hallucination_reduction_configuration.zig").HallucinationReductionConfiguration;
const AppliedOrchestrationConfiguration = @import("applied_orchestration_configuration.zig").AppliedOrchestrationConfiguration;
const ResponseScope = @import("response_scope.zig").ResponseScope;
const TopicConfiguration = @import("topic_configuration.zig").TopicConfiguration;

pub const GetChatControlsConfigurationInput = struct {
    /// The identifier of the application for which the chat controls are
    /// configured.
    application_id: []const u8,

    /// The maximum number of configured chat controls to return.
    max_results: ?i32 = null,

    /// If the `maxResults` response was incomplete because there is more data to
    /// retrieve, Amazon Q Business returns a pagination token in the response. You
    /// can use this pagination token to retrieve the next set of Amazon Q Business
    /// chat controls configured.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const GetChatControlsConfigurationOutput = struct {
    /// The phrases blocked from chat by your chat control configuration.
    blocked_phrases: ?BlockedPhrasesConfiguration = null,

    /// The configuration details for `CREATOR_MODE`.
    creator_mode_configuration: ?AppliedCreatorModeConfiguration = null,

    /// The hallucination reduction settings for your application.
    hallucination_reduction_configuration: ?HallucinationReductionConfiguration = null,

    /// If the `maxResults` response was incomplete because there is more data to
    /// retrieve, Amazon Q Business returns a pagination token in the response. You
    /// can use this pagination token to retrieve the next set of Amazon Q Business
    /// chat controls configured.
    next_token: ?[]const u8 = null,

    /// The chat response orchestration settings for your application.
    ///
    /// Chat orchestration is optimized to work for English language content. For
    /// more details on language support in Amazon Q Business, see [Supported
    /// languages](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/supported-languages.html).
    orchestration_configuration: ?AppliedOrchestrationConfiguration = null,

    /// The response scope configured for a Amazon Q Business application. This
    /// determines whether your application uses its retrieval augmented generation
    /// (RAG) system to generate answers only from your enterprise data, or also
    /// uses the large language models (LLM) knowledge to respons to end user
    /// questions in chat.
    response_scope: ?ResponseScope = null,

    /// The topic specific controls configured for a Amazon Q Business application.
    topic_configurations: ?[]const TopicConfiguration = null,

    pub const json_field_names = .{
        .blocked_phrases = "blockedPhrases",
        .creator_mode_configuration = "creatorModeConfiguration",
        .hallucination_reduction_configuration = "hallucinationReductionConfiguration",
        .next_token = "nextToken",
        .orchestration_configuration = "orchestrationConfiguration",
        .response_scope = "responseScope",
        .topic_configurations = "topicConfigurations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetChatControlsConfigurationInput, options: CallOptions) !GetChatControlsConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetChatControlsConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/chatcontrols");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetChatControlsConfigurationOutput {
    const result: GetChatControlsConfigurationOutput = try aws.json.parseJsonObject(
        GetChatControlsConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
