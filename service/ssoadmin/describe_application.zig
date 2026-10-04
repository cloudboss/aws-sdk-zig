const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PortalOptions = @import("portal_options.zig").PortalOptions;
const ApplicationStatus = @import("application_status.zig").ApplicationStatus;

pub const DescribeApplicationInput = struct {
    /// Specifies the ARN of the application. For more information about ARNs, see
    /// [Amazon Resource Names (ARNs) and Amazon Web Services Service
    /// Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon
    /// Web Services General Reference*.
    application_arn: []const u8,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
    };
};

pub const DescribeApplicationOutput = struct {
    /// The account ID.
    application_account: ?[]const u8 = null,

    /// Specifies the ARN of the application.
    application_arn: ?[]const u8 = null,

    /// The ARN of the application provider under which the operation will run.
    application_provider_arn: ?[]const u8 = null,

    /// The date the application was created.
    created_date: ?i64 = null,

    /// The Amazon Web Services Region where the application was created in IAM
    /// Identity Center.
    created_from: ?[]const u8 = null,

    /// The description of the .
    description: ?[]const u8 = null,

    /// The ARN of the identity store that is connected to the instance of IAM
    /// Identity Center.
    identity_store_arn: ?[]const u8 = null,

    /// The ARN of the IAM Identity Center application under which the operation
    /// will run. For more information about ARNs, see [Amazon Resource Names (ARNs)
    /// and Amazon Web Services Service
    /// Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon
    /// Web Services General Reference*.
    instance_arn: ?[]const u8 = null,

    /// The application name.
    name: ?[]const u8 = null,

    /// A structure that describes the options for the portal associated with an
    /// application.
    portal_options: ?PortalOptions = null,

    /// Specifies whether the application is enabled or disabled.
    status: ?ApplicationStatus = null,

    pub const json_field_names = .{
        .application_account = "ApplicationAccount",
        .application_arn = "ApplicationArn",
        .application_provider_arn = "ApplicationProviderArn",
        .created_date = "CreatedDate",
        .created_from = "CreatedFrom",
        .description = "Description",
        .identity_store_arn = "IdentityStoreArn",
        .instance_arn = "InstanceArn",
        .name = "Name",
        .portal_options = "PortalOptions",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeApplicationInput, options: CallOptions) !DescribeApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sso", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sso", "SSO Admin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.DescribeApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeApplicationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeApplicationOutput, body, allocator);
}
