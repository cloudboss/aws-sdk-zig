const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoggingConfig = @import("logging_config.zig").LoggingConfig;
const RegistryType = @import("registry_type.zig").RegistryType;
const serde = @import("serde.zig");

pub const RegisterTypeInput = struct {
    /// A unique identifier that acts as an idempotency key for this registration
    /// request.
    /// Specifying a client request token prevents CloudFormation from generating
    /// more than one version of
    /// an extension from the same registration request, even if the request is
    /// submitted multiple
    /// times.
    client_request_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role for CloudFormation to assume
    /// when invoking
    /// the extension.
    ///
    /// For CloudFormation to assume the specified execution role, the role must
    /// contain a trust
    /// relationship with the CloudFormation service principal
    /// (`resources.cloudformation.amazonaws.com`). For more information about
    /// adding
    /// trust relationships, see [Modifying a role trust
    /// policy](https://docs.aws.amazon.com/IAM/latest/UserGuide/roles-managingrole-editing-console.html#roles-managingrole_edit-trust-policy) in the *Identity and Access Management User
    /// Guide*.
    ///
    /// If your extension calls Amazon Web Services APIs in any of its handlers, you
    /// must create an
    /// *
    /// [IAM
    /// execution
    /// role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html)
    /// * that includes the necessary permissions to call those
    /// Amazon Web Services APIs, and provision that execution role in your account.
    /// When CloudFormation needs to invoke
    /// the resource type handler, CloudFormation assumes this execution role to
    /// create a temporary
    /// session token, which it then passes to the resource type handler, thereby
    /// supplying your
    /// resource type with the appropriate credentials.
    execution_role_arn: ?[]const u8 = null,

    /// Specifies logging configuration information for an extension.
    logging_config: ?LoggingConfig = null,

    /// A URL to the S3 bucket that contains the extension project package that
    /// contains the
    /// necessary files for the extension you want to register.
    ///
    /// For information about generating a schema handler package for the extension
    /// you want to
    /// register, see
    /// [submit](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-cli-submit.html) in
    /// the *CloudFormation Command Line Interface (CLI) User Guide*.
    ///
    /// The user registering the extension must be able to access the package in the
    /// S3 bucket.
    /// That's, the user needs to have
    /// [GetObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html) permissions for the schema
    /// handler package. For more information, see [Actions, Resources, and
    /// Condition Keys for
    /// Amazon
    /// S3](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazons3.html) in
    /// the *Identity and Access Management User Guide*.
    schema_handler_package: []const u8,

    /// The kind of extension.
    type: ?RegistryType = null,

    /// The name of the extension being registered.
    ///
    /// We suggest that extension names adhere to the following patterns:
    ///
    /// * For resource types, `company_or_organization::service::type`.
    ///
    /// * For modules, `company_or_organization::service::type::MODULE`.
    ///
    /// * For Hooks, `MyCompany::Testing::MyTestHook`.
    ///
    /// The following organization namespaces are reserved and can't be used in your
    /// extension
    /// names:
    ///
    /// * `Alexa`
    ///
    /// * `AMZN`
    ///
    /// * `Amazon`
    ///
    /// * `AWS`
    ///
    /// * `Custom`
    ///
    /// * `Dev`
    type_name: []const u8,
};

pub const RegisterTypeOutput = struct {
    /// The identifier for this registration request.
    ///
    /// Use this registration token when calling DescribeTypeRegistration, which
    /// returns information about the status and IDs of the extension registration.
    registration_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterTypeInput, options: CallOptions) !RegisterTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=RegisterType&Version=2010-05-15");
    if (input.client_request_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientRequestToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.execution_role_arn) |v| {
        try body_buf.appendSlice(allocator, "&ExecutionRoleArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.logging_config) |v| {
        try body_buf.appendSlice(allocator, "&LoggingConfig.LogGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.log_group_name);
        try body_buf.appendSlice(allocator, "&LoggingConfig.LogRoleArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.log_role_arn);
    }
    try body_buf.appendSlice(allocator, "&SchemaHandlerPackage=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.schema_handler_package);
    if (input.type) |v| {
        try body_buf.appendSlice(allocator, "&Type=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&TypeName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.type_name);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterTypeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RegisterTypeResult")) break;
            },
            else => {},
        }
    }

    var result: RegisterTypeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RegistrationToken")) {
                    result.registration_token = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
