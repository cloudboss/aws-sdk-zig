const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RegistryType = @import("registry_type.zig").RegistryType;
const DeprecatedStatus = @import("deprecated_status.zig").DeprecatedStatus;
const LoggingConfig = @import("logging_config.zig").LoggingConfig;
const ProvisioningType = @import("provisioning_type.zig").ProvisioningType;
const RequiredActivatedType = @import("required_activated_type.zig").RequiredActivatedType;
const TypeTestsStatus = @import("type_tests_status.zig").TypeTestsStatus;
const Visibility = @import("visibility.zig").Visibility;
const serde = @import("serde.zig");

pub const DescribeTypeInput = struct {
    /// The Amazon Resource Name (ARN) of the extension.
    ///
    /// Conditional: You must specify either `TypeName` and `Type`, or
    /// `Arn`.
    arn: ?[]const u8 = null,

    /// The version number of a public third-party extension.
    public_version_number: ?[]const u8 = null,

    /// The publisher ID of the extension publisher.
    ///
    /// Extensions provided by Amazon Web Services are not assigned a publisher ID.
    publisher_id: ?[]const u8 = null,

    /// The kind of extension.
    ///
    /// Conditional: You must specify either `TypeName` and `Type`, or
    /// `Arn`.
    @"type": ?RegistryType = null,

    /// The name of the extension.
    ///
    /// Conditional: You must specify either `TypeName` and `Type`, or
    /// `Arn`.
    type_name: ?[]const u8 = null,

    /// The ID of a specific version of the extension. The version ID is the value
    /// at the end of
    /// the Amazon Resource Name (ARN) assigned to the extension version when it is
    /// registered.
    ///
    /// If you specify a `VersionId`, `DescribeType` returns information
    /// about that specific extension version. Otherwise, it returns information
    /// about the default
    /// extension version.
    version_id: ?[]const u8 = null,
};

pub const DescribeTypeOutput = struct {
    /// The Amazon Resource Name (ARN) of the extension.
    arn: ?[]const u8 = null,

    /// Whether CloudFormation automatically updates the extension in this account
    /// and Region when a
    /// new *minor* version is published by the extension publisher. Major versions
    /// released by the publisher must be manually updated. For more information,
    /// see [Automatically use new versions of
    /// extensions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry-public.html#registry-public-enable-auto) in the
    /// *CloudFormation User Guide*.
    auto_update: ?bool = null,

    /// A JSON string that represent the current configuration data for the
    /// extension in this
    /// account and Region.
    ///
    /// To set the configuration data for an extension, use
    /// [SetTypeConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_SetTypeConfiguration.html).
    configuration_schema: ?[]const u8 = null,

    /// The ID of the default version of the extension. The default version is used
    /// when the
    /// extension version isn't specified.
    ///
    /// This applies only to private extensions you have registered in your account.
    /// For public
    /// extensions, both those provided by Amazon Web Services and published by
    /// third parties, CloudFormation returns
    /// `null`. For more information, see
    /// [RegisterType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_RegisterType.html).
    ///
    /// To set the default version of an extension, use SetTypeDefaultVersion.
    default_version_id: ?[]const u8 = null,

    /// The deprecation status of the extension version.
    ///
    /// Valid values include:
    ///
    /// * `LIVE`: The extension is activated or registered and can be used in
    /// CloudFormation operations, dependent on its provisioning behavior and
    /// visibility scope.
    ///
    /// * `DEPRECATED`: The extension has been deactivated or deregistered and can
    ///   no
    /// longer be used in CloudFormation operations.
    ///
    /// For public third-party extensions, CloudFormation returns `null`.
    deprecated_status: ?DeprecatedStatus = null,

    /// The description of the extension.
    description: ?[]const u8 = null,

    /// The URL of a page providing detailed documentation for this extension.
    documentation_url: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM execution role used to register
    /// the extension.
    /// This applies only to private extensions you have registered in your account.
    /// For more
    /// information, see
    /// [RegisterType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_RegisterType.html).
    ///
    /// If the registered extension calls any Amazon Web Services APIs, you must
    /// create an *
    /// [IAM execution
    /// role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html)
    /// * that includes the necessary permissions to call those Amazon Web Services
    ///   APIs,
    /// and provision that execution role in your account. CloudFormation then
    /// assumes that execution role
    /// to provide your extension with the appropriate credentials.
    execution_role_arn: ?[]const u8 = null,

    /// Whether the extension is activated in the account and Region.
    ///
    /// This only applies to public third-party extensions. For all other
    /// extensions, CloudFormation
    /// returns `null`.
    is_activated: ?bool = null,

    /// Whether the specified extension version is set as the default version.
    ///
    /// This applies only to private extensions you have registered in your account,
    /// and
    /// extensions published by Amazon Web Services. For public third-party
    /// extensions, whether they are activated
    /// in your account, CloudFormation returns `null`.
    is_default_version: ?bool = null,

    /// When the specified extension version was registered. This applies only to:
    ///
    /// * Private extensions you have registered in your account. For more
    ///   information, see
    /// [RegisterType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_RegisterType.html).
    ///
    /// * Public extensions you have activated in your account with auto-update
    ///   specified. For
    /// more information, see
    /// [ActivateType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ActivateType.html).
    last_updated: ?i64 = null,

    /// The latest version of a public extension *that is available* for
    /// use.
    ///
    /// This only applies if you specify a public extension, and you don't specify a
    /// version. For
    /// all other requests, CloudFormation returns `null`.
    latest_public_version: ?[]const u8 = null,

    /// Contains logging configuration information for private extensions. This
    /// applies only to
    /// private extensions you have registered in your account. For public
    /// extensions, both those
    /// provided by Amazon Web Services and published by third parties,
    /// CloudFormation returns `null`. For
    /// more information, see
    /// [RegisterType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_RegisterType.html).
    logging_config: ?LoggingConfig = null,

    /// For public extensions that have been activated for this account and Region,
    /// the Amazon
    /// Resource Name (ARN) of the public extension.
    original_type_arn: ?[]const u8 = null,

    /// For public extensions that have been activated for this account and Region,
    /// the type name
    /// of the public extension.
    ///
    /// If you specified a `TypeNameAlias` when enabling the extension in this
    /// account
    /// and Region, CloudFormation treats that alias as the extension's type name
    /// within the account and
    /// Region, not the type name of the public extension. For more information, see
    /// [Use aliases to refer to
    /// extensions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry-public.html#registry-public-enable-alias) in the
    /// *CloudFormation User Guide*.
    original_type_name: ?[]const u8 = null,

    /// For resource type extensions, the provisioning behavior of the resource
    /// type. CloudFormation
    /// determines the provisioning type during registration, based on the types of
    /// handlers in the
    /// schema handler package submitted.
    ///
    /// Valid values include:
    ///
    /// * `FULLY_MUTABLE`: The resource type includes an update handler to process
    /// updates to the type during stack update operations.
    ///
    /// * `IMMUTABLE`: The resource type doesn't include an update handler, so the
    /// type can't be updated and must instead be replaced during stack update
    /// operations.
    ///
    /// * `NON_PROVISIONABLE`: The resource type doesn't include all the following
    /// handlers, and therefore can't actually be provisioned.
    ///
    /// * create
    ///
    /// * read
    ///
    /// * delete
    provisioning_type: ?ProvisioningType = null,

    /// The version number of a public third-party extension.
    ///
    /// This applies only if you specify a public extension you have activated in
    /// your account, or
    /// specify a public extension without specifying a version. For all other
    /// extensions, CloudFormation
    /// returns `null`.
    public_version_number: ?[]const u8 = null,

    /// The publisher ID of the extension publisher.
    ///
    /// This applies only to public third-party extensions. For private registered
    /// extensions, and
    /// extensions provided by Amazon Web Services, CloudFormation returns `null`.
    publisher_id: ?[]const u8 = null,

    /// For extensions that are modules, the public third-party extensions that must
    /// be activated
    /// in your account in order for the module itself to be activated.
    required_activated_types: ?[]const RequiredActivatedType = null,

    /// The schema that defines the extension.
    ///
    /// For more information, see [Resource type
    /// schema](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-schema.html) in the *CloudFormation Command Line Interface (CLI) User Guide* and the [CloudFormation Hooks User Guide](https://docs.aws.amazon.com/cloudformation-cli/latest/hooks-userguide/what-is-cloudformation-hooks.html).
    schema: ?[]const u8 = null,

    /// The URL of the source code for the extension.
    source_url: ?[]const u8 = null,

    /// When the specified private extension version was registered or activated in
    /// your
    /// account.
    time_created: ?i64 = null,

    /// The kind of extension.
    @"type": ?RegistryType = null,

    /// The name of the extension.
    ///
    /// If the extension is a public third-party type you have activated with a type
    /// name alias,
    /// CloudFormation returns the type name alias. For more information, see
    /// [ActivateType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ActivateType.html).
    type_name: ?[]const u8 = null,

    /// The contract test status of the registered extension version. To return the
    /// extension test
    /// status of a specific extension version, you must specify `VersionId`.
    ///
    /// This applies only to registered private extension versions. CloudFormation
    /// doesn't return this
    /// information for public extensions, whether they are activated in your
    /// account.
    ///
    /// * `PASSED`: The extension has passed all its contract tests.
    ///
    /// An extension must have a test status of `PASSED` before it can be
    /// published. For more information, see [Publishing
    /// extensions to make them available for public
    /// use](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-publish.html) in the
    /// *CloudFormation Command Line Interface (CLI) User Guide*.
    ///
    /// * `FAILED`: The extension has failed one or more contract tests.
    ///
    /// * `IN_PROGRESS`: Contract tests are currently being performed on the
    /// extension.
    ///
    /// * `NOT_TESTED`: Contract tests haven't been performed on the
    /// extension.
    type_tests_status: ?TypeTestsStatus = null,

    /// The description of the test status. To return the extension test status of a
    /// specific
    /// extension version, you must specify `VersionId`.
    ///
    /// This applies only to registered private extension versions. CloudFormation
    /// doesn't return this
    /// information for public extensions, whether they are activated in your
    /// account.
    type_tests_status_description: ?[]const u8 = null,

    /// The scope at which the extension is visible and usable in CloudFormation
    /// operations.
    ///
    /// Valid values include:
    ///
    /// * `PRIVATE`: The extension is only visible and usable within the account in
    /// which it is registered. CloudFormation marks any extensions you register as
    /// `PRIVATE`.
    ///
    /// * `PUBLIC`: The extension is publicly visible and usable within any Amazon
    ///   Web Services
    /// account.
    visibility: ?Visibility = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTypeInput, options: Options) !DescribeTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudformation");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DescribeType&Version=2010-05-15");
    if (input.arn) |v| {
        try body_buf.appendSlice(allocator, "&Arn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.public_version_number) |v| {
        try body_buf.appendSlice(allocator, "&PublicVersionNumber=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.publisher_id) |v| {
        try body_buf.appendSlice(allocator, "&PublisherId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.@"type") |v| {
        try body_buf.appendSlice(allocator, "&Type=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.type_name) |v| {
        try body_buf.appendSlice(allocator, "&TypeName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.version_id) |v| {
        try body_buf.appendSlice(allocator, "&VersionId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTypeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeTypeResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeTypeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoUpdate")) {
                    result.auto_update = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ConfigurationSchema")) {
                    result.configuration_schema = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultVersionId")) {
                    result.default_version_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeprecatedStatus")) {
                    result.deprecated_status = std.meta.stringToEnum(DeprecatedStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DocumentationUrl")) {
                    result.documentation_url = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExecutionRoleArn")) {
                    result.execution_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsActivated")) {
                    result.is_activated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IsDefaultVersion")) {
                    result.is_default_version = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LastUpdated")) {
                    result.last_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LatestPublicVersion")) {
                    result.latest_public_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LoggingConfig")) {
                    result.logging_config = try serde.deserializeLoggingConfig(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "OriginalTypeArn")) {
                    result.original_type_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginalTypeName")) {
                    result.original_type_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProvisioningType")) {
                    result.provisioning_type = std.meta.stringToEnum(ProvisioningType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicVersionNumber")) {
                    result.public_version_number = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublisherId")) {
                    result.publisher_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequiredActivatedTypes")) {
                    result.required_activated_types = try serde.deserializeRequiredActivatedTypes(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Schema")) {
                    result.schema = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceUrl")) {
                    result.source_url = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TimeCreated")) {
                    result.time_created = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(RegistryType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeName")) {
                    result.type_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeTestsStatus")) {
                    result.type_tests_status = std.meta.stringToEnum(TypeTestsStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeTestsStatusDescription")) {
                    result.type_tests_status_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Visibility")) {
                    result.visibility = std.meta.stringToEnum(Visibility, try reader.readElementText());
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CFNRegistryException")) {
        return .{ .arena = arena, .kind = .{ .cfn_registry_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ChangeSetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .change_set_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentResourcesLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_resources_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CreatedButModifiedException")) {
        return .{ .arena = arena, .kind = .{ .created_but_modified_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GeneratedTemplateNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .generated_template_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HookResultNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .hook_result_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientCapabilitiesException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_capabilities_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidChangeSetStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_change_set_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateTransitionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_transition_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NameAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .name_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationIdAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .operation_id_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationInProgressException")) {
        return .{ .arena = arena, .kind = .{ .operation_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationStatusCheckFailedException")) {
        return .{ .arena = arena, .kind = .{ .operation_status_check_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceScanInProgressException")) {
        return .{ .arena = arena, .kind = .{ .resource_scan_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceScanLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_scan_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceScanNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_scan_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackInstanceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_instance_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackRefactorNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_refactor_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackSetNotEmptyException")) {
        return .{ .arena = arena, .kind = .{ .stack_set_not_empty_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackSetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_set_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StaleRequestException")) {
        return .{ .arena = arena, .kind = .{ .stale_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TokenAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .token_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeConfigurationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .type_configuration_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .type_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
