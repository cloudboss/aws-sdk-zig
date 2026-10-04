const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RehydrationType = @import("rehydration_type.zig").RehydrationType;

pub const CreatePersistentContactAssociationInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// This is the contactId of the current contact that the
    /// `CreatePersistentContactAssociation` API is
    /// being called from.
    initial_contact_id: []const u8,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The contactId chosen for rehydration depends on the type chosen.
    ///
    /// * `ENTIRE_PAST_SESSION`: Rehydrates a chat from the most recently terminated
    ///   past chat contact of the
    /// specified past ended chat session. To use this type, provide the
    /// `initialContactId` of the past ended
    /// chat session in the `sourceContactId` field. In this type, Connect Customer
    /// determines what the most
    /// recent chat contact on the past ended chat session and uses it to start a
    /// persistent chat.
    ///
    /// * `FROM_SEGMENT`: Rehydrates a chat from the specified past chat contact
    ///   provided in the
    /// `sourceContactId` field.
    ///
    /// The actual contactId used for rehydration is provided in the response of
    /// this API.
    ///
    /// To illustrate how to use rehydration type, consider the following example: A
    /// customer starts a chat session.
    /// Agent a1 accepts the chat and a conversation starts between the customer and
    /// Agent a1. This first contact creates a
    /// contact ID **C1**. Agent a1 then transfers the chat to Agent a2. This
    /// creates another
    /// contact ID **C2**. At this point Agent a2 ends the chat. The customer is
    /// forwarded to
    /// the disconnect flow for a post chat survey that creates another contact ID
    /// **C3**. After
    /// the chat survey, the chat session ends. Later, the customer returns and
    /// wants to resume their past chat session. At
    /// this point, the customer can have following use cases:
    ///
    /// * **Use Case 1**: The customer wants to continue the past chat session but
    ///   they
    /// want to hide the post chat survey. For this they will use the following
    /// configuration:
    ///
    /// * **Configuration**
    ///
    /// * SourceContactId = "C2"
    ///
    /// * RehydrationType = "FROM_SEGMENT"
    ///
    /// * **Expected behavior**
    ///
    /// * This starts a persistent chat session from the specified past ended
    ///   contact (C2). Transcripts of past chat
    /// sessions C2 and C1 are accessible in the current persistent chat session.
    /// Note that chat segment C3 is dropped
    /// from the persistent chat session.
    ///
    /// * **Use Case 2**: The customer wants to continue the past chat session and
    ///   see the
    /// transcript of the entire past engagement, including the post chat survey.
    /// For this they will use the following
    /// configuration:
    ///
    /// * **Configuration**
    ///
    /// * SourceContactId = "C1"
    ///
    /// * RehydrationType = "ENTIRE_PAST_SESSION"
    ///
    /// * **Expected behavior**
    ///
    /// * This starts a persistent chat session from the most recently ended chat
    ///   contact (C3). Transcripts of past
    /// chat sessions C3, C2 and C1 are accessible in the current persistent chat
    /// session.
    rehydration_type: RehydrationType,

    /// The contactId from which a persistent chat session must be started.
    source_contact_id: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .initial_contact_id = "InitialContactId",
        .instance_id = "InstanceId",
        .rehydration_type = "RehydrationType",
        .source_contact_id = "SourceContactId",
    };
};

pub const CreatePersistentContactAssociationOutput = struct {
    /// The contactId from which a persistent chat session is started. This field is
    /// populated only for persistent
    /// chat.
    continued_from_contact_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .continued_from_contact_id = "ContinuedFromContactId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePersistentContactAssociationInput, options: CallOptions) !CreatePersistentContactAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePersistentContactAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/contact/persistent-contact-association/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.initial_contact_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RehydrationType\":");
    try aws.json.writeValue(@TypeOf(input.rehydration_type), input.rehydration_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SourceContactId\":");
    try aws.json.writeValue(@TypeOf(input.source_contact_id), input.source_contact_id, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePersistentContactAssociationOutput {
    const result: CreatePersistentContactAssociationOutput = try aws.json.parseJsonObject(
        CreatePersistentContactAssociationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
