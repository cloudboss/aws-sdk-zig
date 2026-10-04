const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AliasConfiguration = @import("alias_configuration.zig").AliasConfiguration;

pub const DescribeEmailAddressInput = struct {
    /// The identifier of the email address.
    email_address_id: []const u8,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    pub const json_field_names = .{
        .email_address_id = "EmailAddressId",
        .instance_id = "InstanceId",
    };
};

pub const DescribeEmailAddressOutput = struct {
    /// A list of alias configurations associated with this email address. Contains
    /// details about email addresses that
    /// forward to this primary email address. The list can contain at most one
    /// alias configuration per email address.
    alias_configurations: ?[]const AliasConfiguration = null,

    /// The email address creation timestamp in ISO 8601 Datetime.
    create_timestamp: ?[]const u8 = null,

    /// The description of the email address.
    description: ?[]const u8 = null,

    /// The display name of email address
    display_name: ?[]const u8 = null,

    /// The email address, including the domain.
    email_address: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the email address.
    email_address_arn: ?[]const u8 = null,

    /// The identifier of the email address.
    email_address_id: ?[]const u8 = null,

    /// The email address last modification timestamp in ISO 8601 Datetime.
    modified_timestamp: ?[]const u8 = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .alias_configurations = "AliasConfigurations",
        .create_timestamp = "CreateTimestamp",
        .description = "Description",
        .display_name = "DisplayName",
        .email_address = "EmailAddress",
        .email_address_arn = "EmailAddressArn",
        .email_address_id = "EmailAddressId",
        .modified_timestamp = "ModifiedTimestamp",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEmailAddressInput, options: CallOptions) !DescribeEmailAddressOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEmailAddressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/email-addresses/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.email_address_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEmailAddressOutput {
    const result: DescribeEmailAddressOutput = try aws.json.parseJsonObject(
        DescribeEmailAddressOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
