const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActivationStatus = @import("activation_status.zig").ActivationStatus;
const ContactChannelAddress = @import("contact_channel_address.zig").ContactChannelAddress;
const ChannelType = @import("channel_type.zig").ChannelType;

pub const GetContactChannelInput = struct {
    /// The Amazon Resource Name (ARN) of the contact channel you want information
    /// about.
    contact_channel_id: []const u8,

    pub const json_field_names = .{
        .contact_channel_id = "ContactChannelId",
    };
};

pub const GetContactChannelOutput = struct {
    /// A Boolean value indicating if the contact channel has been activated or not.
    activation_status: ?ActivationStatus = null,

    /// The ARN of the contact that the channel belongs to.
    contact_arn: []const u8,

    /// The ARN of the contact channel.
    contact_channel_arn: []const u8,

    /// The details that Incident Manager uses when trying to engage the contact
    /// channel.
    delivery_address: ?ContactChannelAddress = null,

    /// The name of the contact channel
    name: []const u8,

    /// The type of contact channel. The type is `SMS`, `VOICE`, or
    /// `EMAIL`.
    type: ChannelType,

    pub const json_field_names = .{
        .activation_status = "ActivationStatus",
        .contact_arn = "ContactArn",
        .contact_channel_arn = "ContactChannelArn",
        .delivery_address = "DeliveryAddress",
        .name = "Name",
        .type = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetContactChannelInput, options: CallOptions) !GetContactChannelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetContactChannelInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.GetContactChannel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetContactChannelOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetContactChannelOutput, body, allocator);
}
