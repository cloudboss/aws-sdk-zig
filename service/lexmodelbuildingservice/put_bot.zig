const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Statement = @import("statement.zig").Statement;
const Prompt = @import("prompt.zig").Prompt;
const Intent = @import("intent.zig").Intent;
const Locale = @import("locale.zig").Locale;
const ProcessBehavior = @import("process_behavior.zig").ProcessBehavior;
const Tag = @import("tag.zig").Tag;
const Status = @import("status.zig").Status;

pub const PutBotInput = struct {
    /// When Amazon Lex can't understand the user's input in context, it tries
    /// to elicit the information a few times. After that, Amazon Lex sends the
    /// message
    /// defined in `abortStatement` to the user, and then cancels the
    /// conversation. To set the number of retries, use the
    /// `valueElicitationPrompt` field for the slot type.
    ///
    /// For example, in a pizza ordering bot, Amazon Lex might ask a user "What
    /// type of crust would you like?" If the user's response is not one of the
    /// expected responses (for example, "thin crust, "deep dish," etc.), Amazon Lex
    /// tries to elicit a correct response a few more times.
    ///
    /// For example, in a pizza ordering application,
    /// `OrderPizza` might be one of the intents. This intent might
    /// require the `CrustType` slot. You specify the
    /// `valueElicitationPrompt` field when you create the
    /// `CrustType` slot.
    ///
    /// If you have defined a fallback intent the cancel statement will not be
    /// sent to the user, the fallback intent is used instead. For more
    /// information, see [
    /// AMAZON.FallbackIntent](https://docs.aws.amazon.com/lex/latest/dg/built-in-intent-fallback.html).
    abort_statement: ?Statement = null,

    /// Identifies a specific revision of the `$LATEST`
    /// version.
    ///
    /// When you create a new bot, leave the `checksum` field
    /// blank. If you specify a checksum you get a
    /// `BadRequestException` exception.
    ///
    /// When you want to update a bot, set the `checksum` field
    /// to the checksum of the most recent revision of the `$LATEST`
    /// version. If you don't specify the ` checksum` field, or if the
    /// checksum does not match the `$LATEST` version, you get a
    /// `PreconditionFailedException` exception.
    checksum: ?[]const u8 = null,

    /// For each Amazon Lex bot created with the Amazon Lex Model Building Service,
    /// you must specify whether your use of Amazon Lex is related to a website,
    /// program, or other application that is directed or targeted, in whole or in
    /// part, to children under age 13 and subject to the Children's Online
    /// Privacy Protection Act (COPPA) by specifying `true` or
    /// `false` in the `childDirected` field. By
    /// specifying `true` in the `childDirected` field, you
    /// confirm that your use of Amazon Lex **is** related
    /// to a website, program, or other application that is directed or targeted,
    /// in whole or in part, to children under age 13 and subject to COPPA. By
    /// specifying `false` in the `childDirected` field, you
    /// confirm that your use of Amazon Lex **is not**
    /// related to a website, program, or other application that is directed or
    /// targeted, in whole or in part, to children under age 13 and subject to
    /// COPPA. You may not specify a default value for the
    /// `childDirected` field that does not accurately reflect
    /// whether your use of Amazon Lex is related to a website, program, or other
    /// application that is directed or targeted, in whole or in part, to children
    /// under age 13 and subject to COPPA.
    ///
    /// If your use of Amazon Lex relates to a website, program, or other
    /// application that is directed in whole or in part, to children under age
    /// 13, you must obtain any required verifiable parental consent under COPPA.
    /// For information regarding the use of Amazon Lex in connection with websites,
    /// programs, or other applications that are directed or targeted, in whole or
    /// in part, to children under age 13, see the [Amazon Lex
    /// FAQ.](https://aws.amazon.com/lex/faqs#data-security)
    child_directed: bool,

    /// When Amazon Lex doesn't understand the user's intent, it uses this
    /// message to get clarification. To specify how many times Amazon Lex should
    /// repeat the clarification prompt, use the `maxAttempts` field.
    /// If Amazon Lex still doesn't understand, it sends the message in the
    /// `abortStatement` field.
    ///
    /// When you create a clarification prompt, make sure that it suggests
    /// the correct response from the user. for example, for a bot that orders
    /// pizza and drinks, you might create this clarification prompt: "What would
    /// you like to do? You can say 'Order a pizza' or 'Order a drink.'"
    ///
    /// If you have defined a fallback intent, it will be invoked if the
    /// clarification prompt is repeated the number of times defined in the
    /// `maxAttempts` field. For more information, see [
    /// AMAZON.FallbackIntent](https://docs.aws.amazon.com/lex/latest/dg/built-in-intent-fallback.html).
    ///
    /// If you don't define a clarification prompt, at runtime Amazon Lex will
    /// return a 400 Bad Request exception in three cases:
    ///
    /// * Follow-up prompt - When the user responds to a follow-up prompt
    /// but does not provide an intent. For example, in response to a
    /// follow-up prompt that says "Would you like anything else today?" the
    /// user says "Yes." Amazon Lex will return a 400 Bad Request exception because
    /// it does not have a clarification prompt to send to the user to get an
    /// intent.
    ///
    /// * Lambda function - When using a Lambda function, you return an
    /// `ElicitIntent` dialog type. Since Amazon Lex does not have a
    /// clarification prompt to get an intent from the user, it returns a 400
    /// Bad Request exception.
    ///
    /// * PutSession operation - When using the `PutSession`
    /// operation, you send an `ElicitIntent` dialog type. Since
    /// Amazon Lex does not have a clarification prompt to get an intent from the
    /// user, it returns a 400 Bad Request exception.
    clarification_prompt: ?Prompt = null,

    /// When set to `true` a new numbered version of the bot is
    /// created. This is the same as calling the `CreateBotVersion`
    /// operation. If you don't specify `createVersion`, the default is
    /// `false`.
    create_version: ?bool = null,

    /// A description of the bot.
    description: ?[]const u8 = null,

    /// When set to `true` user utterances are sent to Amazon
    /// Comprehend for sentiment analysis. If you don't specify
    /// `detectSentiment`, the default is `false`.
    detect_sentiment: ?bool = null,

    /// Set to `true` to enable access to natural language
    /// understanding improvements.
    ///
    /// When you set the `enableModelImprovements` parameter to
    /// `true` you can use the
    /// `nluIntentConfidenceThreshold` parameter to configure
    /// confidence scores. For more information, see [Confidence
    /// Scores](https://docs.aws.amazon.com/lex/latest/dg/confidence-scores.html).
    ///
    /// You can only set the `enableModelImprovements` parameter in
    /// certain Regions. If you set the parameter to `true`, your bot
    /// has access to accuracy improvements.
    ///
    /// The Regions where you can set the `enableModelImprovements`
    /// parameter to `true` are:
    ///
    /// * US East (N. Virginia) (us-east-1)
    ///
    /// * US West (Oregon) (us-west-2)
    ///
    /// * Asia Pacific (Sydney) (ap-southeast-2)
    ///
    /// * EU (Ireland) (eu-west-1)
    ///
    /// In other Regions, the `enableModelImprovements` parameter
    /// is set to `true` by default. In these Regions setting the
    /// parameter to `false` throws a `ValidationException`
    /// exception.
    enable_model_improvements: ?bool = null,

    /// The maximum time in seconds that Amazon Lex retains the data gathered in
    /// a conversation.
    ///
    /// A user interaction session remains active for the amount of time
    /// specified. If no conversation occurs during this time, the session expires
    /// and Amazon Lex deletes any data provided before the timeout.
    ///
    /// For example, suppose that a user chooses the OrderPizza intent, but
    /// gets sidetracked halfway through placing an order. If the user doesn't
    /// complete the order within the specified time, Amazon Lex discards the slot
    /// information that it gathered, and the user must start over.
    ///
    /// If you don't include the `idleSessionTTLInSeconds`
    /// element in a `PutBot` operation request, Amazon Lex uses the default
    /// value. This is also true if the request replaces an existing
    /// bot.
    ///
    /// The default is 300 seconds (5 minutes).
    idle_session_ttl_in_seconds: ?i32 = null,

    /// An array of `Intent` objects. Each intent represents a
    /// command that a user can express. For example, a pizza ordering bot might
    /// support an OrderPizza intent. For more information, see how-it-works.
    intents: ?[]const Intent = null,

    /// Specifies the target locale for the bot. Any intent used in the
    /// bot must be compatible with the locale of the bot.
    ///
    /// The default is `en-US`.
    locale: Locale,

    /// The name of the bot. The name is *not* case
    /// sensitive.
    name: []const u8,

    /// Determines the threshold where Amazon Lex will insert the
    /// `AMAZON.FallbackIntent`,
    /// `AMAZON.KendraSearchIntent`, or both when returning
    /// alternative intents in a
    /// [PostContent](https://docs.aws.amazon.com/lex/latest/dg/API_runtime_PostContent.html) or
    /// [PostText](https://docs.aws.amazon.com/lex/latest/dg/API_runtime_PostText.html) response.
    /// `AMAZON.FallbackIntent` and
    /// `AMAZON.KendraSearchIntent` are only inserted if they are
    /// configured for the bot.
    ///
    /// You must set the `enableModelImprovements` parameter to
    /// `true` to use confidence scores in the following
    /// regions.
    ///
    /// * US East (N. Virginia) (us-east-1)
    ///
    /// * US West (Oregon) (us-west-2)
    ///
    /// * Asia Pacific (Sydney) (ap-southeast-2)
    ///
    /// * EU (Ireland) (eu-west-1)
    ///
    /// In other Regions, the `enableModelImprovements` parameter
    /// is set to `true` by default.
    ///
    /// For example, suppose a bot is configured with the confidence threshold
    /// of 0.80 and the `AMAZON.FallbackIntent`. Amazon Lex returns three
    /// alternative intents with the following confidence scores: IntentA (0.70),
    /// IntentB (0.60), IntentC (0.50). The response from the
    /// `PostText` operation would be:
    ///
    /// * AMAZON.FallbackIntent
    ///
    /// * IntentA
    ///
    /// * IntentB
    ///
    /// * IntentC
    nlu_intent_confidence_threshold: ?f64 = null,

    /// If you set the `processBehavior` element to
    /// `BUILD`, Amazon Lex builds the bot so that it can be run. If you
    /// set the element to `SAVE` Amazon Lex saves the bot, but doesn't
    /// build it.
    ///
    /// If you don't specify this value, the default value is
    /// `BUILD`.
    process_behavior: ?ProcessBehavior = null,

    /// A list of tags to add to the bot. You can only add tags when you
    /// create a bot, you can't use the `PutBot` operation to update
    /// the tags on a bot. To update tags, use the `TagResource`
    /// operation.
    tags: ?[]const Tag = null,

    /// The Amazon Polly voice ID that you want Amazon Lex to use for voice
    /// interactions with the user. The locale configured for the voice must match
    /// the locale of the bot. For more information, see [Voices
    /// in Amazon Polly](https://docs.aws.amazon.com/polly/latest/dg/voicelist.html)
    /// in the *Amazon Polly Developer
    /// Guide*.
    voice_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .abort_statement = "abortStatement",
        .checksum = "checksum",
        .child_directed = "childDirected",
        .clarification_prompt = "clarificationPrompt",
        .create_version = "createVersion",
        .description = "description",
        .detect_sentiment = "detectSentiment",
        .enable_model_improvements = "enableModelImprovements",
        .idle_session_ttl_in_seconds = "idleSessionTTLInSeconds",
        .intents = "intents",
        .locale = "locale",
        .name = "name",
        .nlu_intent_confidence_threshold = "nluIntentConfidenceThreshold",
        .process_behavior = "processBehavior",
        .tags = "tags",
        .voice_id = "voiceId",
    };
};

pub const PutBotOutput = struct {
    /// The message that Amazon Lex uses to cancel a conversation. For more
    /// information, see PutBot.
    abort_statement: ?Statement = null,

    /// Checksum of the bot that you created.
    checksum: ?[]const u8 = null,

    /// For each Amazon Lex bot created with the Amazon Lex Model Building Service,
    /// you must specify whether your use of Amazon Lex is related to a website,
    /// program, or other application that is directed or targeted, in whole or in
    /// part, to children under age 13 and subject to the Children's Online
    /// Privacy Protection Act (COPPA) by specifying `true` or
    /// `false` in the `childDirected` field. By
    /// specifying `true` in the `childDirected` field, you
    /// confirm that your use of Amazon Lex **is** related
    /// to a website, program, or other application that is directed or targeted,
    /// in whole or in part, to children under age 13 and subject to COPPA. By
    /// specifying `false` in the `childDirected` field, you
    /// confirm that your use of Amazon Lex **is not**
    /// related to a website, program, or other application that is directed or
    /// targeted, in whole or in part, to children under age 13 and subject to
    /// COPPA. You may not specify a default value for the
    /// `childDirected` field that does not accurately reflect
    /// whether your use of Amazon Lex is related to a website, program, or other
    /// application that is directed or targeted, in whole or in part, to children
    /// under age 13 and subject to COPPA.
    ///
    /// If your use of Amazon Lex relates to a website, program, or other
    /// application that is directed in whole or in part, to children under age
    /// 13, you must obtain any required verifiable parental consent under COPPA.
    /// For information regarding the use of Amazon Lex in connection with websites,
    /// programs, or other applications that are directed or targeted, in whole or
    /// in part, to children under age 13, see the [Amazon Lex
    /// FAQ.](https://aws.amazon.com/lex/faqs#data-security)
    child_directed: ?bool = null,

    /// The prompts that Amazon Lex uses when it doesn't understand the user's
    /// intent. For more information, see PutBot.
    clarification_prompt: ?Prompt = null,

    /// The date that the bot was created.
    created_date: ?i64 = null,

    /// `True` if a new version of the bot was created. If the
    /// `createVersion` field was not specified in the request, the
    /// `createVersion` field is set to false in the
    /// response.
    create_version: ?bool = null,

    /// A description of the bot.
    description: ?[]const u8 = null,

    /// `true` if the bot is configured to send user utterances to
    /// Amazon Comprehend for sentiment analysis. If the
    /// `detectSentiment` field was not specified in the request, the
    /// `detectSentiment` field is `false` in the
    /// response.
    detect_sentiment: ?bool = null,

    /// Indicates whether the bot uses accuracy improvements.
    /// `true` indicates that the bot is using the improvements,
    /// otherwise, `false`.
    enable_model_improvements: ?bool = null,

    /// If `status` is `FAILED`, Amazon Lex provides the
    /// reason that it failed to build the bot.
    failure_reason: ?[]const u8 = null,

    /// The maximum length of time that Amazon Lex retains the data gathered in
    /// a conversation. For more information, see PutBot.
    idle_session_ttl_in_seconds: ?i32 = null,

    /// An array of `Intent` objects. For more information, see
    /// PutBot.
    intents: ?[]const Intent = null,

    /// The date that the bot was updated. When you create a resource, the
    /// creation date and last updated date are the same.
    last_updated_date: ?i64 = null,

    /// The target locale for the bot.
    locale: ?Locale = null,

    /// The name of the bot.
    name: ?[]const u8 = null,

    /// The score that determines where Amazon Lex inserts the
    /// `AMAZON.FallbackIntent`,
    /// `AMAZON.KendraSearchIntent`, or both when returning
    /// alternative intents in a
    /// [PostContent](https://docs.aws.amazon.com/lex/latest/dg/API_runtime_PostContent.html) or
    /// [PostText](https://docs.aws.amazon.com/lex/latest/dg/API_runtime_PostText.html) response.
    /// `AMAZON.FallbackIntent` is inserted if the confidence score
    /// for all intents is below this value.
    /// `AMAZON.KendraSearchIntent` is only inserted if it is
    /// configured for the bot.
    nlu_intent_confidence_threshold: ?f64 = null,

    /// When you send a request to create a bot with
    /// `processBehavior` set to `BUILD`, Amazon Lex sets the
    /// `status` response element to `BUILDING`.
    ///
    /// In the `READY_BASIC_TESTING` state you can test the bot
    /// with user inputs that exactly match the utterances configured for the
    /// bot's intents and values in the slot types.
    ///
    /// If Amazon Lex can't build the bot, Amazon Lex sets `status` to
    /// `FAILED`. Amazon Lex returns the reason for the failure in the
    /// `failureReason` response element.
    ///
    /// When you set `processBehavior` to `SAVE`,
    /// Amazon Lex sets the status code to `NOT BUILT`.
    ///
    /// When the bot is in the `READY` state you can test and
    /// publish the bot.
    status: ?Status = null,

    /// A list of tags associated with the bot.
    tags: ?[]const Tag = null,

    /// The version of the bot. For a new bot, the version is always
    /// `$LATEST`.
    version: ?[]const u8 = null,

    /// The Amazon Polly voice ID that Amazon Lex uses for voice interaction
    /// with the user. For more information, see PutBot.
    voice_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .abort_statement = "abortStatement",
        .checksum = "checksum",
        .child_directed = "childDirected",
        .clarification_prompt = "clarificationPrompt",
        .created_date = "createdDate",
        .create_version = "createVersion",
        .description = "description",
        .detect_sentiment = "detectSentiment",
        .enable_model_improvements = "enableModelImprovements",
        .failure_reason = "failureReason",
        .idle_session_ttl_in_seconds = "idleSessionTTLInSeconds",
        .intents = "intents",
        .last_updated_date = "lastUpdatedDate",
        .locale = "locale",
        .name = "name",
        .nlu_intent_confidence_threshold = "nluIntentConfidenceThreshold",
        .status = "status",
        .tags = "tags",
        .version = "version",
        .voice_id = "voiceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutBotInput, options: CallOptions) !PutBotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lex");

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutBotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/versions/$LATEST");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.abort_statement) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"abortStatement\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.checksum) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"checksum\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"childDirected\":");
    try aws.json.writeValue(@TypeOf(input.child_directed), input.child_directed, allocator, &body_buf);
    has_prev = true;
    if (input.clarification_prompt) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clarificationPrompt\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.create_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"createVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.detect_sentiment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"detectSentiment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enable_model_improvements) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enableModelImprovements\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.idle_session_ttl_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"idleSessionTTLInSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.intents) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"intents\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"locale\":");
    try aws.json.writeValue(@TypeOf(input.locale), input.locale, allocator, &body_buf);
    has_prev = true;
    if (input.nlu_intent_confidence_threshold) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nluIntentConfidenceThreshold\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.process_behavior) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"processBehavior\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.voice_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"voiceId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutBotOutput {
    var result: PutBotOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutBotOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
