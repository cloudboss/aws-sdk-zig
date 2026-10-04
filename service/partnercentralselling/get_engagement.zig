const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EngagementContextDetails = @import("engagement_context_details.zig").EngagementContextDetails;

pub const GetEngagementInput = struct {
    /// Specifies the catalog related to the engagement request. Valid values are
    /// `AWS` and `Sandbox`.
    catalog: []const u8,

    /// Specifies the identifier of the Engagement record to retrieve.
    identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .identifier = "Identifier",
    };
};

pub const GetEngagementOutput = struct {
    /// The Amazon Resource Name (ARN) of the engagement retrieved.
    arn: ?[]const u8 = null,

    /// A list of context objects associated with the engagement. Each context
    /// provides additional information related to the Engagement, such as customer
    /// projects or documents.
    contexts: ?[]const EngagementContextDetails = null,

    /// The date and time when the Engagement was created, presented in ISO 8601
    /// format (UTC). For example: "2023-05-01T20:37:46Z". This timestamp helps
    /// track the lifecycle of the Engagement.
    created_at: ?i64 = null,

    /// The AWS account ID of the user who originally created the engagement. This
    /// field helps in tracking the origin of the engagement.
    created_by: ?[]const u8 = null,

    /// A more detailed description of the engagement. This provides additional
    /// context or information about the engagement's purpose or scope.
    description: ?[]const u8 = null,

    /// The unique resource identifier of the engagement retrieved.
    id: ?[]const u8 = null,

    /// Specifies the current count of members participating in the Engagement. This
    /// count includes all active members regardless of their roles or permissions
    /// within the Engagement.
    member_count: ?i32 = null,

    /// The timestamp indicating when the engagement was last modified, in ISO 8601
    /// format (UTC). Example: "2023-05-01T20:37:46Z". This helps track the most
    /// recent changes to the engagement.
    modified_at: ?i64 = null,

    /// The AWS account ID of the user who last modified the engagement. This field
    /// helps track who made the most recent changes to the engagement.
    modified_by: ?[]const u8 = null,

    /// The title of the engagement. It provides a brief, descriptive name for the
    /// engagement that is meaningful and easily recognizable.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .contexts = "Contexts",
        .created_at = "CreatedAt",
        .created_by = "CreatedBy",
        .description = "Description",
        .id = "Id",
        .member_count = "MemberCount",
        .modified_at = "ModifiedAt",
        .modified_by = "ModifiedBy",
        .title = "Title",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEngagementInput, options: CallOptions) !GetEngagementOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEngagementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.GetEngagement");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEngagementOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetEngagementOutput, body, allocator);
}
