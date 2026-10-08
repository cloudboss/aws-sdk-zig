const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContactChannelAddress = @import("contact_channel_address.zig").ContactChannelAddress;
const ChannelType = @import("channel_type.zig").ChannelType;

pub const CreateContactChannelInput = struct {
    /// The Amazon Resource Name (ARN) of the contact you are adding the contact
    /// channel
    /// to.
    contact_id: []const u8,

    /// If you want to activate the channel at a later time, you can choose to defer
    /// activation.
    /// Incident Manager can't engage your contact channel until it has been
    /// activated.
    defer_activation: ?bool = null,

    /// The details that Incident Manager uses when trying to engage the contact
    /// channel. The format
    /// is dependent on the type of the contact channel. The following are the
    /// expected
    /// formats:
    ///
    /// * SMS - '+' followed by the country code and phone number
    ///
    /// * VOICE - '+' followed by the country code and phone number
    ///
    /// * EMAIL - any standard email format
    delivery_address: ContactChannelAddress,

    /// A token ensuring that the operation is called only once with the specified
    /// details.
    idempotency_token: ?[]const u8 = null,

    /// The name of the contact channel.
    name: []const u8,

    /// Incident Manager supports three types of contact channels:
    ///
    /// * `SMS`
    ///
    /// * `VOICE`
    ///
    /// * `EMAIL`
    type: ChannelType,

    pub const json_field_names = .{
        .contact_id = "ContactId",
        .defer_activation = "DeferActivation",
        .delivery_address = "DeliveryAddress",
        .idempotency_token = "IdempotencyToken",
        .name = "Name",
        .type = "Type",
    };
};

pub const CreateContactChannelOutput = struct {
    /// The Amazon Resource Name (ARN) of the contact channel.
    contact_channel_arn: []const u8,

    pub const json_field_names = .{
        .contact_channel_arn = "ContactChannelArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateContactChannelInput, options: CallOptions) !CreateContactChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-contacts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateContactChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-contacts", "SSM Contacts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.CreateContactChannel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateContactChannelOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateContactChannelOutput, body, allocator);
}
