const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Logging = @import("logging.zig").Logging;
const Tag = @import("tag.zig").Tag;

pub const CreateProfileInput = struct {
    /// Specifies the name for the business associated with this profile.
    business_name: []const u8,

    /// Reserved for future use.
    client_token: ?[]const u8 = null,

    /// Specifies the email address associated with this customer profile.
    email: ?[]const u8 = null,

    /// Specifies whether or not logging is enabled for this profile.
    logging: Logging,

    /// Specifies the name of the profile.
    name: []const u8,

    /// Specifies the phone number associated with the profile.
    phone: []const u8,

    /// Specifies the key-value pairs assigned to ARNs that you can use to group and
    /// search for resources by type. You can attach this metadata to resources
    /// (capabilities, partnerships, and so on) for any purpose.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .business_name = "businessName",
        .client_token = "clientToken",
        .email = "email",
        .logging = "logging",
        .name = "name",
        .phone = "phone",
        .tags = "tags",
    };
};

pub const CreateProfileOutput = struct {
    /// Returns the name for the business associated with this profile.
    business_name: []const u8,

    /// Returns a timestamp representing the time the profile was created.
    created_at: i64,

    /// Returns the email address associated with this customer profile.
    email: ?[]const u8 = null,

    /// Returns whether or not logging is turned on for this profile.
    logging: ?Logging = null,

    /// Returns the name of the logging group.
    log_group_name: ?[]const u8 = null,

    /// Returns the name of the profile, used to identify it.
    name: []const u8,

    /// Returns the phone number associated with the profile.
    phone: []const u8,

    /// Returns an Amazon Resource Name (ARN) for the profile.
    profile_arn: []const u8,

    /// Returns the unique, system-generated identifier for the profile.
    profile_id: []const u8,

    pub const json_field_names = .{
        .business_name = "businessName",
        .created_at = "createdAt",
        .email = "email",
        .logging = "logging",
        .log_group_name = "logGroupName",
        .name = "name",
        .phone = "phone",
        .profile_arn = "profileArn",
        .profile_id = "profileId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProfileInput, options: CallOptions) !CreateProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "b2bi", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("b2bi", "b2bi", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "B2BI.CreateProfile");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProfileOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateProfileOutput, body, allocator);
}
