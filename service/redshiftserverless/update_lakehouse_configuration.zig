const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LakehouseIdcRegistration = @import("lakehouse_idc_registration.zig").LakehouseIdcRegistration;
const LakehouseRegistration = @import("lakehouse_registration.zig").LakehouseRegistration;

pub const UpdateLakehouseConfigurationInput = struct {
    /// The name of the Glue Data Catalog that will be associated with the namespace
    /// enabled with Amazon Redshift federated permissions.
    ///
    /// Pattern: `^[a-z0-9_-]*[a-z]+[a-z0-9_-]*$`
    catalog_name: ?[]const u8 = null,

    /// A boolean value that, if `true`, validates the request without actually
    /// updating the lakehouse configuration. Use this to check for errors before
    /// making changes.
    dry_run: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM Identity Center application used
    /// for enabling Amazon Web Services IAM Identity Center trusted identity
    /// propagation on a namespace enabled with Amazon Redshift federated
    /// permissions.
    lakehouse_idc_application_arn: ?[]const u8 = null,

    /// Modifies the Amazon Web Services IAM Identity Center trusted identity
    /// propagation on a namespace enabled with Amazon Redshift federated
    /// permissions. Valid values are `Associate` or `Disassociate`.
    lakehouse_idc_registration: ?LakehouseIdcRegistration = null,

    /// Specifies whether to register or deregister the namespace with Amazon
    /// Redshift federated permissions. Valid values are `Register` or `Deregister`.
    lakehouse_registration: ?LakehouseRegistration = null,

    /// The name of the namespace whose lakehouse configuration you want to modify.
    namespace_name: []const u8,

    pub const json_field_names = .{
        .catalog_name = "catalogName",
        .dry_run = "dryRun",
        .lakehouse_idc_application_arn = "lakehouseIdcApplicationArn",
        .lakehouse_idc_registration = "lakehouseIdcRegistration",
        .lakehouse_registration = "lakehouseRegistration",
        .namespace_name = "namespaceName",
    };
};

pub const UpdateLakehouseConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) of the Glue Data Catalog associated with the
    /// lakehouse configuration.
    catalog_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM Identity Center application used
    /// for enabling Amazon Web Services IAM Identity Center trusted identity
    /// propagation.
    lakehouse_idc_application_arn: ?[]const u8 = null,

    /// The current status of the lakehouse registration. Indicates whether the
    /// namespace is successfully registered with Amazon Redshift federated
    /// permissions.
    lakehouse_registration_status: ?[]const u8 = null,

    /// The name of the namespace.
    namespace_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_arn = "catalogArn",
        .lakehouse_idc_application_arn = "lakehouseIdcApplicationArn",
        .lakehouse_registration_status = "lakehouseRegistrationStatus",
        .namespace_name = "namespaceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLakehouseConfigurationInput, options: CallOptions) !UpdateLakehouseConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLakehouseConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.UpdateLakehouseConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLakehouseConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateLakehouseConfigurationOutput, body, allocator);
}
