const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateContactAttributesInput = struct {
    /// The Amazon Connect attributes. These attributes can be accessed in flows
    /// just like any other contact
    /// attributes.
    ///
    /// You can have up to 32,768 UTF-8 bytes across all attributes for a contact.
    /// Attribute keys can include only
    /// alphanumeric, dash, and underscore characters.
    ///
    /// In the [Set contact
    /// attributes](https://docs.aws.amazon.com/connect/latest/adminguide/set-contact-attributes.html) block, when the attributes for a contact exceed 32 KB, the contact is routed down the Error
    /// branch of the flow. As a mitigation, consider the following options:
    ///
    /// * Remove unnecessary attributes by setting their values to empty.
    ///
    /// * If the attributes are only used in one flow and don't need to be referred
    ///   to outside of that flow (for
    /// example, by a Lambda or another flow), then use flow attributes. This way
    /// you aren't needlessly persisting the 32 KB
    /// of information from one flow to another. For more information, see [Flow
    /// block: Set contact
    /// attributes](https://docs.aws.amazon.com/connect/latest/adminguide/set-contact-attributes.html) in the
    /// *Amazon Connect Administrator Guide*.
    attributes: []const aws.map.StringMapEntry,

    /// The identifier of the contact. This is the identifier of the contact
    /// associated with the first interaction with
    /// the contact center.
    initial_contact_id: []const u8,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .initial_contact_id = "InitialContactId",
        .instance_id = "InstanceId",
    };
};

pub const UpdateContactAttributesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateContactAttributesInput, options: CallOptions) !UpdateContactAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateContactAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/contact/attributes";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Attributes\":");
    try aws.json.writeValue(@TypeOf(input.attributes), input.attributes, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InitialContactId\":");
    try aws.json.writeValue(@TypeOf(input.initial_contact_id), input.initial_contact_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstanceId\":");
    try aws.json.writeValue(@TypeOf(input.instance_id), input.instance_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateContactAttributesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateContactAttributesOutput = .{};

    return result;
}
