const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const Tag = @import("tag.zig").Tag;
const ParameterTier = @import("parameter_tier.zig").ParameterTier;
const ParameterType = @import("parameter_type.zig").ParameterType;

pub const PutParameterInput = struct {
    /// A regular expression used to validate the parameter value. For example, for
    /// String types
    /// with values restricted to numbers, you can specify the following:
    /// AllowedPattern=^\d+$
    allowed_pattern: ?[]const u8 = null,

    /// The data type for a `String` parameter. Supported data types include plain
    /// text
    /// and Amazon Machine Image (AMI) IDs.
    ///
    /// **The following data type values are supported.**
    ///
    /// * `text`
    ///
    /// * `aws:ec2:image`
    ///
    /// * `aws:ssm:integration`
    ///
    /// When you create a `String` parameter and specify `aws:ec2:image`,
    /// Amazon Web Services Systems Manager validates the parameter value is in the
    /// required format, such as
    /// `ami-12345abcdeEXAMPLE`, and that the specified AMI is available in your
    /// Amazon Web Services account.
    ///
    /// If the action is successful, the service sends back an HTTP 200 response
    /// which indicates a
    /// successful `PutParameter` call for all cases except for data type
    /// `aws:ec2:image`. If you call `PutParameter` with
    /// `aws:ec2:image` data type, a successful HTTP 200 response does not guarantee
    /// that
    /// your parameter was successfully created or updated. The `aws:ec2:image`
    /// value is
    /// validated asynchronously, and the `PutParameter` call returns before the
    /// validation
    /// is complete. If you submit an invalid AMI value, the PutParameter operation
    /// will return success,
    /// but the asynchronous validation will fail and the parameter will not be
    /// created or updated. To
    /// monitor whether your `aws:ec2:image` parameters are created successfully,
    /// see [Setting
    /// up notifications or trigger actions based on Parameter Store
    /// events](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-cwe.html). For more
    /// information about AMI format validation , see [Native parameter
    /// support for Amazon Machine Image
    /// IDs](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-ec2-aliases.html).
    data_type: ?[]const u8 = null,

    /// Information about the parameter that you want to add to the system. Optional
    /// but
    /// recommended.
    ///
    /// Don't enter personally identifiable information in this field.
    description: ?[]const u8 = null,

    /// The Key Management Service (KMS) ID that you want to use to encrypt a
    /// parameter. Use a custom key for better security. Required for parameters
    /// that use the `SecureString` data type.
    ///
    /// If you don't specify a key ID, the system uses the default key associated
    /// with your
    /// Amazon Web Services account, which is not as secure as using a custom key.
    ///
    /// * To use a custom KMS key, choose the `SecureString`
    /// data type with the `Key ID` parameter.
    key_id: ?[]const u8 = null,

    /// The fully qualified name of the parameter that you want to create or update.
    ///
    /// You can't enter the Amazon Resource Name (ARN) for a parameter, only the
    /// parameter name
    /// itself.
    ///
    /// The fully qualified name includes the complete hierarchy of the parameter
    /// path and name. For
    /// parameters in a hierarchy, you must include a leading forward slash
    /// character (/) when you create
    /// or reference a parameter. For example: `/Dev/DBServer/MySQL/db-string13`
    ///
    /// Naming Constraints:
    ///
    /// * Parameter names are case sensitive.
    ///
    /// * A parameter name must be unique within an Amazon Web Services Region
    ///
    /// * A parameter name can't be prefixed with "`aws`" or "`ssm`"
    /// (case-insensitive).
    ///
    /// * Parameter names can include only the following symbols and letters:
    /// `a-zA-Z0-9_.-`
    ///
    /// In addition, the slash character ( / ) is used to delineate hierarchies in
    /// parameter
    /// names. For example: `/Dev/Production/East/Project-ABC/MyParameter`
    ///
    /// * Parameter names can't contain spaces. The service removes any spaces
    ///   specified for
    /// the beginning or end of a parameter name. If the specified name for a
    /// parameter contains spaces
    /// between characters, the request fails with a `ValidationException` error.
    ///
    /// * Parameter hierarchies are limited to a maximum depth of fifteen levels.
    ///
    /// For additional information about valid values for parameter names, see
    /// [Creating Systems Manager
    /// parameters](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-su-create.html) in the *Amazon Web Services Systems Manager User Guide*.
    ///
    /// The reported maximum length of 2048 characters for a parameter name includes
    /// 1037
    /// characters that are reserved for internal use by Systems Manager. The
    /// maximum length for a parameter name
    /// that you specify is 1011 characters.
    ///
    /// This count of 1011 characters includes the characters in the ARN that
    /// precede the name you
    /// specify. This ARN length will vary depending on your partition and Region.
    /// For example, the
    /// following 45 characters count toward the 1011 character maximum for a
    /// parameter created in the
    /// US East (Ohio) Region: `arn:aws:ssm:us-east-2:111122223333:parameter/`.
    name: []const u8,

    /// Overwrite an existing parameter. The default value is `false`.
    overwrite: ?bool = null,

    /// One or more policies to apply to a parameter. This operation takes a JSON
    /// array. Parameter
    /// Store, a tool in Amazon Web Services Systems Manager supports the following
    /// policy types:
    ///
    /// Expiration: This policy deletes the parameter after it expires. When you
    /// create the policy,
    /// you specify the expiration date. You can update the expiration date and time
    /// by updating the
    /// policy. Updating the *parameter* doesn't affect the expiration date and
    /// time.
    /// When the expiration time is reached, Parameter Store deletes the parameter.
    ///
    /// ExpirationNotification: This policy initiates an event in Amazon CloudWatch
    /// Events that
    /// notifies you about the expiration. By using this policy, you can receive
    /// notification before or
    /// after the expiration time is reached, in units of days or hours.
    ///
    /// NoChangeNotification: This policy initiates a CloudWatch Events event if a
    /// parameter hasn't
    /// been modified for a specified period of time. This policy type is useful
    /// when, for example, a
    /// secret needs to be changed within a period of time, but it hasn't been
    /// changed.
    ///
    /// All existing policies are preserved until you send new policies or an empty
    /// policy. For more
    /// information about parameter policies, see [Assigning parameter
    /// policies](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-policies.html).
    policies: ?[]const u8 = null,

    /// Optional metadata that you assign to a resource. Tags enable you to
    /// categorize a resource in
    /// different ways, such as by purpose, owner, or environment. For example, you
    /// might want to tag a
    /// Systems Manager parameter to identify the type of resource to which it
    /// applies, the environment, or the
    /// type of configuration data referenced by the parameter. In this case, you
    /// could specify the
    /// following key-value pairs:
    ///
    /// * `Key=Resource,Value=S3bucket`
    ///
    /// * `Key=OS,Value=Windows`
    ///
    /// * `Key=ParameterType,Value=LicenseKey`
    ///
    /// To add tags to an existing Systems Manager parameter, use the
    /// AddTagsToResource
    /// operation.
    tags: ?[]const Tag = null,

    /// The parameter tier to assign to a parameter.
    ///
    /// Parameter Store offers a standard tier and an advanced tier for parameters.
    /// Standard
    /// parameters have a content size limit of 4 KB and can't be configured to use
    /// parameter policies.
    /// You can create a maximum of 10,000 standard parameters for each Region in an
    /// Amazon Web Services account.
    /// Standard parameters are offered at no additional cost.
    ///
    /// Advanced parameters have a content size limit of 8 KB and can be configured
    /// to use parameter
    /// policies. You can create a maximum of 100,000 advanced parameters for each
    /// Region in an
    /// Amazon Web Services account. Advanced parameters incur a charge. For more
    /// information, see [Managing
    /// parameter
    /// tiers](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-advanced-parameters.html) in the *Amazon Web Services Systems Manager User Guide*.
    ///
    /// You can change a standard parameter to an advanced parameter any time. But
    /// you can't revert
    /// an advanced parameter to a standard parameter. Reverting an advanced
    /// parameter to a standard
    /// parameter would result in data loss because the system would truncate the
    /// size of the parameter
    /// from 8 KB to 4 KB. Reverting would also remove any policies attached to the
    /// parameter. Lastly,
    /// advanced parameters use a different form of encryption than standard
    /// parameters.
    ///
    /// If you no longer need an advanced parameter, or if you no longer want to
    /// incur charges for
    /// an advanced parameter, you must delete it and recreate it as a new standard
    /// parameter.
    ///
    /// **Using the Default Tier Configuration**
    ///
    /// In `PutParameter` requests, you can specify the tier to create the parameter
    /// in.
    /// Whenever you specify a tier in the request, Parameter Store creates or
    /// updates the parameter
    /// according to that request. However, if you don't specify a tier in a
    /// request, Parameter Store
    /// assigns the tier based on the current Parameter Store default tier
    /// configuration.
    ///
    /// The default tier when you begin using Parameter Store is the
    /// standard-parameter tier. If you
    /// use the advanced-parameter tier, you can specify one of the following as the
    /// default:
    ///
    /// * **Advanced**: With this option, Parameter Store evaluates all
    /// requests as advanced parameters.
    ///
    /// * **Intelligent-Tiering**: With this option, Parameter Store
    /// evaluates each request to determine if the parameter is standard or
    /// advanced.
    ///
    /// If the request doesn't include any options that require an advanced
    /// parameter, the
    /// parameter is created in the standard-parameter tier. If one or more options
    /// requiring an
    /// advanced parameter are included in the request, Parameter Store create a
    /// parameter in the
    /// advanced-parameter tier.
    ///
    /// This approach helps control your parameter-related costs by always creating
    /// standard
    /// parameters unless an advanced parameter is necessary.
    ///
    /// Options that require an advanced parameter include the following:
    ///
    /// * The content size of the parameter is more than 4 KB.
    ///
    /// * The parameter uses a parameter policy.
    ///
    /// * More than 10,000 parameters already exist in your Amazon Web Services
    ///   account in the current
    /// Amazon Web Services Region.
    ///
    /// For more information about configuring the default tier option, see
    /// [Specifying a default parameter
    /// tier](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-advanced-parameters.html#ps-default-tier) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    tier: ?ParameterTier = null,

    /// The type of parameter that you want to create.
    ///
    /// `SecureString` isn't currently supported for CloudFormation templates.
    ///
    /// Items in a `StringList` must be separated by a comma (,). You can't
    /// use other punctuation or special character to escape items in the list. If
    /// you have a parameter
    /// value that requires a comma, then use the `String` data type.
    ///
    /// Specifying a parameter type isn't required when updating a parameter. You
    /// must specify a
    /// parameter type when creating a parameter.
    @"type": ?ParameterType = null,

    /// The parameter value that you want to add to the system. Standard parameters
    /// have a value
    /// limit of 4 KB. Advanced parameters have a value limit of 8 KB.
    ///
    /// Parameters can't be referenced or nested in the values of other parameters.
    /// You can't
    /// include values wrapped in double brackets `{{}}` or
    /// `{{ssm:*parameter-name*}}` in a parameter value.
    value: []const u8,

    pub const json_field_names = .{
        .allowed_pattern = "AllowedPattern",
        .data_type = "DataType",
        .description = "Description",
        .key_id = "KeyId",
        .name = "Name",
        .overwrite = "Overwrite",
        .policies = "Policies",
        .tags = "Tags",
        .tier = "Tier",
        .@"type" = "Type",
        .value = "Value",
    };
};

pub const PutParameterOutput = struct {
    /// The tier assigned to the parameter.
    tier: ?ParameterTier = null,

    /// The new version number of a parameter. If you edit a parameter value,
    /// Parameter Store
    /// automatically creates a new version and assigns this new version a unique
    /// ID. You can reference a
    /// parameter version ID in API operations or in Systems Manager documents (SSM
    /// documents). By default, if you
    /// don't specify a specific version, the system returns the latest parameter
    /// value when a parameter
    /// is called.
    version: ?i64 = null,

    pub const json_field_names = .{
        .tier = "Tier",
        .version = "Version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutParameterInput, options: CallOptions) !PutParameterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: PutParameterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.PutParameter");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutParameterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutParameterOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        const parsed_error: ?errors.AlreadyExistsException = aws.json.parseJsonObject(errors.AlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociatedInstances")) {
        const parsed_error: ?errors.AssociatedInstances = aws.json.parseJsonObject(errors.AssociatedInstances, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .associated_instances = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociationAlreadyExists")) {
        const parsed_error: ?errors.AssociationAlreadyExists = aws.json.parseJsonObject(errors.AssociationAlreadyExists, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .association_already_exists = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociationDoesNotExist")) {
        const parsed_error: ?errors.AssociationDoesNotExist = aws.json.parseJsonObject(errors.AssociationDoesNotExist, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .association_does_not_exist = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociationExecutionDoesNotExist")) {
        const parsed_error: ?errors.AssociationExecutionDoesNotExist = aws.json.parseJsonObject(errors.AssociationExecutionDoesNotExist, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .association_execution_does_not_exist = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociationLimitExceeded")) {
        const parsed_error: ?errors.AssociationLimitExceeded = aws.json.parseJsonObject(errors.AssociationLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .association_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociationVersionLimitExceeded")) {
        const parsed_error: ?errors.AssociationVersionLimitExceeded = aws.json.parseJsonObject(errors.AssociationVersionLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .association_version_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionNotApprovedException")) {
        const parsed_error: ?errors.AutomationDefinitionNotApprovedException = aws.json.parseJsonObject(errors.AutomationDefinitionNotApprovedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_definition_not_approved_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionNotFoundException")) {
        const parsed_error: ?errors.AutomationDefinitionNotFoundException = aws.json.parseJsonObject(errors.AutomationDefinitionNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_definition_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionVersionNotFoundException")) {
        const parsed_error: ?errors.AutomationDefinitionVersionNotFoundException = aws.json.parseJsonObject(errors.AutomationDefinitionVersionNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_definition_version_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationExecutionLimitExceededException")) {
        const parsed_error: ?errors.AutomationExecutionLimitExceededException = aws.json.parseJsonObject(errors.AutomationExecutionLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_execution_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationExecutionNotFoundException")) {
        const parsed_error: ?errors.AutomationExecutionNotFoundException = aws.json.parseJsonObject(errors.AutomationExecutionNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_execution_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationStepNotFoundException")) {
        const parsed_error: ?errors.AutomationStepNotFoundException = aws.json.parseJsonObject(errors.AutomationStepNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_step_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ComplianceTypeCountLimitExceededException")) {
        const parsed_error: ?errors.ComplianceTypeCountLimitExceededException = aws.json.parseJsonObject(errors.ComplianceTypeCountLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .compliance_type_count_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CustomSchemaCountLimitExceededException")) {
        const parsed_error: ?errors.CustomSchemaCountLimitExceededException = aws.json.parseJsonObject(errors.CustomSchemaCountLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .custom_schema_count_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DocumentAlreadyExists")) {
        const parsed_error: ?errors.DocumentAlreadyExists = aws.json.parseJsonObject(errors.DocumentAlreadyExists, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .document_already_exists = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DocumentLimitExceeded")) {
        const parsed_error: ?errors.DocumentLimitExceeded = aws.json.parseJsonObject(errors.DocumentLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .document_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DocumentPermissionLimit")) {
        const parsed_error: ?errors.DocumentPermissionLimit = aws.json.parseJsonObject(errors.DocumentPermissionLimit, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .document_permission_limit = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DocumentVersionLimitExceeded")) {
        const parsed_error: ?errors.DocumentVersionLimitExceeded = aws.json.parseJsonObject(errors.DocumentVersionLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .document_version_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DoesNotExistException")) {
        const parsed_error: ?errors.DoesNotExistException = aws.json.parseJsonObject(errors.DoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateDocumentContent")) {
        const parsed_error: ?errors.DuplicateDocumentContent = aws.json.parseJsonObject(errors.DuplicateDocumentContent, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_document_content = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateDocumentVersionName")) {
        const parsed_error: ?errors.DuplicateDocumentVersionName = aws.json.parseJsonObject(errors.DuplicateDocumentVersionName, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_document_version_name = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateInstanceId")) {
        const parsed_error: ?errors.DuplicateInstanceId = aws.json.parseJsonObject(errors.DuplicateInstanceId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_instance_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FeatureNotAvailableException")) {
        const parsed_error: ?errors.FeatureNotAvailableException = aws.json.parseJsonObject(errors.FeatureNotAvailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .feature_not_available_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "HierarchyLevelLimitExceededException")) {
        const parsed_error: ?errors.HierarchyLevelLimitExceededException = aws.json.parseJsonObject(errors.HierarchyLevelLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .hierarchy_level_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "HierarchyTypeMismatchException")) {
        const parsed_error: ?errors.HierarchyTypeMismatchException = aws.json.parseJsonObject(errors.HierarchyTypeMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .hierarchy_type_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatch")) {
        const parsed_error: ?errors.IdempotentParameterMismatch = aws.json.parseJsonObject(errors.IdempotentParameterMismatch, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IncompatiblePolicyException")) {
        const parsed_error: ?errors.IncompatiblePolicyException = aws.json.parseJsonObject(errors.IncompatiblePolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .incompatible_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        const parsed_error: ?errors.InternalServerError = aws.json.parseJsonObject(errors.InternalServerError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidActivation")) {
        const parsed_error: ?errors.InvalidActivation = aws.json.parseJsonObject(errors.InvalidActivation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_activation = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidActivationId")) {
        const parsed_error: ?errors.InvalidActivationId = aws.json.parseJsonObject(errors.InvalidActivationId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_activation_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAggregatorException")) {
        const parsed_error: ?errors.InvalidAggregatorException = aws.json.parseJsonObject(errors.InvalidAggregatorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_aggregator_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAllowedPatternException")) {
        const parsed_error: ?errors.InvalidAllowedPatternException = aws.json.parseJsonObject(errors.InvalidAllowedPatternException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_allowed_pattern_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAssociation")) {
        const parsed_error: ?errors.InvalidAssociation = aws.json.parseJsonObject(errors.InvalidAssociation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_association = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAssociationVersion")) {
        const parsed_error: ?errors.InvalidAssociationVersion = aws.json.parseJsonObject(errors.InvalidAssociationVersion, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_association_version = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationExecutionParametersException")) {
        const parsed_error: ?errors.InvalidAutomationExecutionParametersException = aws.json.parseJsonObject(errors.InvalidAutomationExecutionParametersException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_automation_execution_parameters_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationSignalException")) {
        const parsed_error: ?errors.InvalidAutomationSignalException = aws.json.parseJsonObject(errors.InvalidAutomationSignalException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_automation_signal_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationStatusUpdateException")) {
        const parsed_error: ?errors.InvalidAutomationStatusUpdateException = aws.json.parseJsonObject(errors.InvalidAutomationStatusUpdateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_automation_status_update_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCommandId")) {
        const parsed_error: ?errors.InvalidCommandId = aws.json.parseJsonObject(errors.InvalidCommandId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_command_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeleteInventoryParametersException")) {
        const parsed_error: ?errors.InvalidDeleteInventoryParametersException = aws.json.parseJsonObject(errors.InvalidDeleteInventoryParametersException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_delete_inventory_parameters_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeletionIdException")) {
        const parsed_error: ?errors.InvalidDeletionIdException = aws.json.parseJsonObject(errors.InvalidDeletionIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deletion_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocument")) {
        const parsed_error: ?errors.InvalidDocument = aws.json.parseJsonObject(errors.InvalidDocument, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentContent")) {
        const parsed_error: ?errors.InvalidDocumentContent = aws.json.parseJsonObject(errors.InvalidDocumentContent, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document_content = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentOperation")) {
        const parsed_error: ?errors.InvalidDocumentOperation = aws.json.parseJsonObject(errors.InvalidDocumentOperation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document_operation = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentSchemaVersion")) {
        const parsed_error: ?errors.InvalidDocumentSchemaVersion = aws.json.parseJsonObject(errors.InvalidDocumentSchemaVersion, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document_schema_version = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentType")) {
        const parsed_error: ?errors.InvalidDocumentType = aws.json.parseJsonObject(errors.InvalidDocumentType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentVersion")) {
        const parsed_error: ?errors.InvalidDocumentVersion = aws.json.parseJsonObject(errors.InvalidDocumentVersion, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document_version = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFilter")) {
        const parsed_error: ?errors.InvalidFilter = aws.json.parseJsonObject(errors.InvalidFilter, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_filter = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterKey")) {
        const parsed_error: ?errors.InvalidFilterKey = aws.json.parseJsonObject(errors.InvalidFilterKey, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_filter_key = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterOption")) {
        const parsed_error: ?errors.InvalidFilterOption = aws.json.parseJsonObject(errors.InvalidFilterOption, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_filter_option = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterValue")) {
        const parsed_error: ?errors.InvalidFilterValue = aws.json.parseJsonObject(errors.InvalidFilterValue, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_filter_value = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceId")) {
        const parsed_error: ?errors.InvalidInstanceId = aws.json.parseJsonObject(errors.InvalidInstanceId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_instance_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceInformationFilterValue")) {
        const parsed_error: ?errors.InvalidInstanceInformationFilterValue = aws.json.parseJsonObject(errors.InvalidInstanceInformationFilterValue, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_instance_information_filter_value = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInstancePropertyFilterValue")) {
        const parsed_error: ?errors.InvalidInstancePropertyFilterValue = aws.json.parseJsonObject(errors.InvalidInstancePropertyFilterValue, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_instance_property_filter_value = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryGroupException")) {
        const parsed_error: ?errors.InvalidInventoryGroupException = aws.json.parseJsonObject(errors.InvalidInventoryGroupException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_inventory_group_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryItemContextException")) {
        const parsed_error: ?errors.InvalidInventoryItemContextException = aws.json.parseJsonObject(errors.InvalidInventoryItemContextException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_inventory_item_context_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryRequestException")) {
        const parsed_error: ?errors.InvalidInventoryRequestException = aws.json.parseJsonObject(errors.InvalidInventoryRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_inventory_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidItemContentException")) {
        const parsed_error: ?errors.InvalidItemContentException = aws.json.parseJsonObject(errors.InvalidItemContentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_item_content_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidKeyId")) {
        const parsed_error: ?errors.InvalidKeyId = aws.json.parseJsonObject(errors.InvalidKeyId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_key_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        const parsed_error: ?errors.InvalidNextToken = aws.json.parseJsonObject(errors.InvalidNextToken, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNotificationConfig")) {
        const parsed_error: ?errors.InvalidNotificationConfig = aws.json.parseJsonObject(errors.InvalidNotificationConfig, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_notification_config = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOptionException")) {
        const parsed_error: ?errors.InvalidOptionException = aws.json.parseJsonObject(errors.InvalidOptionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_option_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOutputFolder")) {
        const parsed_error: ?errors.InvalidOutputFolder = aws.json.parseJsonObject(errors.InvalidOutputFolder, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_output_folder = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOutputLocation")) {
        const parsed_error: ?errors.InvalidOutputLocation = aws.json.parseJsonObject(errors.InvalidOutputLocation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_output_location = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameters")) {
        const parsed_error: ?errors.InvalidParameters = aws.json.parseJsonObject(errors.InvalidParameters, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameters = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPermissionType")) {
        const parsed_error: ?errors.InvalidPermissionType = aws.json.parseJsonObject(errors.InvalidPermissionType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_permission_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPluginName")) {
        const parsed_error: ?errors.InvalidPluginName = aws.json.parseJsonObject(errors.InvalidPluginName, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_plugin_name = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyAttributeException")) {
        const parsed_error: ?errors.InvalidPolicyAttributeException = aws.json.parseJsonObject(errors.InvalidPolicyAttributeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_policy_attribute_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyTypeException")) {
        const parsed_error: ?errors.InvalidPolicyTypeException = aws.json.parseJsonObject(errors.InvalidPolicyTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_policy_type_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceId")) {
        const parsed_error: ?errors.InvalidResourceId = aws.json.parseJsonObject(errors.InvalidResourceId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_resource_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceType")) {
        const parsed_error: ?errors.InvalidResourceType = aws.json.parseJsonObject(errors.InvalidResourceType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_resource_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResultAttributeException")) {
        const parsed_error: ?errors.InvalidResultAttributeException = aws.json.parseJsonObject(errors.InvalidResultAttributeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_result_attribute_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRole")) {
        const parsed_error: ?errors.InvalidRole = aws.json.parseJsonObject(errors.InvalidRole, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_role = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSchedule")) {
        const parsed_error: ?errors.InvalidSchedule = aws.json.parseJsonObject(errors.InvalidSchedule, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_schedule = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTag")) {
        const parsed_error: ?errors.InvalidTag = aws.json.parseJsonObject(errors.InvalidTag, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tag = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTarget")) {
        const parsed_error: ?errors.InvalidTarget = aws.json.parseJsonObject(errors.InvalidTarget, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_target = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetMaps")) {
        const parsed_error: ?errors.InvalidTargetMaps = aws.json.parseJsonObject(errors.InvalidTargetMaps, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_target_maps = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTypeNameException")) {
        const parsed_error: ?errors.InvalidTypeNameException = aws.json.parseJsonObject(errors.InvalidTypeNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_type_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidUpdate")) {
        const parsed_error: ?errors.InvalidUpdate = aws.json.parseJsonObject(errors.InvalidUpdate, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_update = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvocationDoesNotExist")) {
        const parsed_error: ?errors.InvocationDoesNotExist = aws.json.parseJsonObject(errors.InvocationDoesNotExist, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invocation_does_not_exist = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ItemContentMismatchException")) {
        const parsed_error: ?errors.ItemContentMismatchException = aws.json.parseJsonObject(errors.ItemContentMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .item_content_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ItemSizeLimitExceededException")) {
        const parsed_error: ?errors.ItemSizeLimitExceededException = aws.json.parseJsonObject(errors.ItemSizeLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .item_size_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MalformedResourcePolicyDocumentException")) {
        const parsed_error: ?errors.MalformedResourcePolicyDocumentException = aws.json.parseJsonObject(errors.MalformedResourcePolicyDocumentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .malformed_resource_policy_document_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxDocumentSizeExceeded")) {
        const parsed_error: ?errors.MaxDocumentSizeExceeded = aws.json.parseJsonObject(errors.MaxDocumentSizeExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_document_size_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoLongerSupportedException")) {
        const parsed_error: ?errors.NoLongerSupportedException = aws.json.parseJsonObject(errors.NoLongerSupportedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_longer_supported_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemAccessDeniedException")) {
        const parsed_error: ?errors.OpsItemAccessDeniedException = aws.json.parseJsonObject(errors.OpsItemAccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemAlreadyExistsException")) {
        const parsed_error: ?errors.OpsItemAlreadyExistsException = aws.json.parseJsonObject(errors.OpsItemAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemConflictException")) {
        const parsed_error: ?errors.OpsItemConflictException = aws.json.parseJsonObject(errors.OpsItemConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemInvalidParameterException")) {
        const parsed_error: ?errors.OpsItemInvalidParameterException = aws.json.parseJsonObject(errors.OpsItemInvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemLimitExceededException")) {
        const parsed_error: ?errors.OpsItemLimitExceededException = aws.json.parseJsonObject(errors.OpsItemLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemNotFoundException")) {
        const parsed_error: ?errors.OpsItemNotFoundException = aws.json.parseJsonObject(errors.OpsItemNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemRelatedItemAlreadyExistsException")) {
        const parsed_error: ?errors.OpsItemRelatedItemAlreadyExistsException = aws.json.parseJsonObject(errors.OpsItemRelatedItemAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_related_item_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemRelatedItemAssociationNotFoundException")) {
        const parsed_error: ?errors.OpsItemRelatedItemAssociationNotFoundException = aws.json.parseJsonObject(errors.OpsItemRelatedItemAssociationNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_related_item_association_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataAlreadyExistsException")) {
        const parsed_error: ?errors.OpsMetadataAlreadyExistsException = aws.json.parseJsonObject(errors.OpsMetadataAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataInvalidArgumentException")) {
        const parsed_error: ?errors.OpsMetadataInvalidArgumentException = aws.json.parseJsonObject(errors.OpsMetadataInvalidArgumentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_invalid_argument_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataKeyLimitExceededException")) {
        const parsed_error: ?errors.OpsMetadataKeyLimitExceededException = aws.json.parseJsonObject(errors.OpsMetadataKeyLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_key_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataLimitExceededException")) {
        const parsed_error: ?errors.OpsMetadataLimitExceededException = aws.json.parseJsonObject(errors.OpsMetadataLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataNotFoundException")) {
        const parsed_error: ?errors.OpsMetadataNotFoundException = aws.json.parseJsonObject(errors.OpsMetadataNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataTooManyUpdatesException")) {
        const parsed_error: ?errors.OpsMetadataTooManyUpdatesException = aws.json.parseJsonObject(errors.OpsMetadataTooManyUpdatesException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_too_many_updates_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterAlreadyExists")) {
        const parsed_error: ?errors.ParameterAlreadyExists = aws.json.parseJsonObject(errors.ParameterAlreadyExists, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_already_exists = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterLimitExceeded")) {
        const parsed_error: ?errors.ParameterLimitExceeded = aws.json.parseJsonObject(errors.ParameterLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterMaxVersionLimitExceeded")) {
        const parsed_error: ?errors.ParameterMaxVersionLimitExceeded = aws.json.parseJsonObject(errors.ParameterMaxVersionLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_max_version_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterNotFound")) {
        const parsed_error: ?errors.ParameterNotFound = aws.json.parseJsonObject(errors.ParameterNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterPatternMismatchException")) {
        const parsed_error: ?errors.ParameterPatternMismatchException = aws.json.parseJsonObject(errors.ParameterPatternMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_pattern_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterVersionLabelLimitExceeded")) {
        const parsed_error: ?errors.ParameterVersionLabelLimitExceeded = aws.json.parseJsonObject(errors.ParameterVersionLabelLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_version_label_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterVersionNotFound")) {
        const parsed_error: ?errors.ParameterVersionNotFound = aws.json.parseJsonObject(errors.ParameterVersionNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_version_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PoliciesLimitExceededException")) {
        const parsed_error: ?errors.PoliciesLimitExceededException = aws.json.parseJsonObject(errors.PoliciesLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .policies_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncAlreadyExistsException")) {
        const parsed_error: ?errors.ResourceDataSyncAlreadyExistsException = aws.json.parseJsonObject(errors.ResourceDataSyncAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_data_sync_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncConflictException")) {
        const parsed_error: ?errors.ResourceDataSyncConflictException = aws.json.parseJsonObject(errors.ResourceDataSyncConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_data_sync_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncCountExceededException")) {
        const parsed_error: ?errors.ResourceDataSyncCountExceededException = aws.json.parseJsonObject(errors.ResourceDataSyncCountExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_data_sync_count_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncInvalidConfigurationException")) {
        const parsed_error: ?errors.ResourceDataSyncInvalidConfigurationException = aws.json.parseJsonObject(errors.ResourceDataSyncInvalidConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_data_sync_invalid_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncNotFoundException")) {
        const parsed_error: ?errors.ResourceDataSyncNotFoundException = aws.json.parseJsonObject(errors.ResourceDataSyncNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_data_sync_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        const parsed_error: ?errors.ResourceInUseException = aws.json.parseJsonObject(errors.ResourceInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        const parsed_error: ?errors.ResourceLimitExceededException = aws.json.parseJsonObject(errors.ResourceLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyConflictException")) {
        const parsed_error: ?errors.ResourcePolicyConflictException = aws.json.parseJsonObject(errors.ResourcePolicyConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_policy_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyInvalidParameterException")) {
        const parsed_error: ?errors.ResourcePolicyInvalidParameterException = aws.json.parseJsonObject(errors.ResourcePolicyInvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_policy_invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyLimitExceededException")) {
        const parsed_error: ?errors.ResourcePolicyLimitExceededException = aws.json.parseJsonObject(errors.ResourcePolicyLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_policy_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyNotFoundException")) {
        const parsed_error: ?errors.ResourcePolicyNotFoundException = aws.json.parseJsonObject(errors.ResourcePolicyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_policy_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceSettingNotFound")) {
        const parsed_error: ?errors.ServiceSettingNotFound = aws.json.parseJsonObject(errors.ServiceSettingNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_setting_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "StatusUnchanged")) {
        const parsed_error: ?errors.StatusUnchanged = aws.json.parseJsonObject(errors.StatusUnchanged, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .status_unchanged = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubTypeCountLimitExceededException")) {
        const parsed_error: ?errors.SubTypeCountLimitExceededException = aws.json.parseJsonObject(errors.SubTypeCountLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .sub_type_count_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TargetInUseException")) {
        const parsed_error: ?errors.TargetInUseException = aws.json.parseJsonObject(errors.TargetInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .target_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TargetNotConnected")) {
        const parsed_error: ?errors.TargetNotConnected = aws.json.parseJsonObject(errors.TargetNotConnected, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .target_not_connected = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsError")) {
        const parsed_error: ?errors.TooManyTagsError = aws.json.parseJsonObject(errors.TooManyTagsError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyUpdates")) {
        const parsed_error: ?errors.TooManyUpdates = aws.json.parseJsonObject(errors.TooManyUpdates, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_updates = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TotalSizeLimitExceededException")) {
        const parsed_error: ?errors.TotalSizeLimitExceededException = aws.json.parseJsonObject(errors.TotalSizeLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .total_size_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedCalendarException")) {
        const parsed_error: ?errors.UnsupportedCalendarException = aws.json.parseJsonObject(errors.UnsupportedCalendarException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_calendar_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedFeatureRequiredException")) {
        const parsed_error: ?errors.UnsupportedFeatureRequiredException = aws.json.parseJsonObject(errors.UnsupportedFeatureRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_feature_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedInventoryItemContextException")) {
        const parsed_error: ?errors.UnsupportedInventoryItemContextException = aws.json.parseJsonObject(errors.UnsupportedInventoryItemContextException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_inventory_item_context_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedInventorySchemaVersionException")) {
        const parsed_error: ?errors.UnsupportedInventorySchemaVersionException = aws.json.parseJsonObject(errors.UnsupportedInventorySchemaVersionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_inventory_schema_version_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperatingSystem")) {
        const parsed_error: ?errors.UnsupportedOperatingSystem = aws.json.parseJsonObject(errors.UnsupportedOperatingSystem, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_operating_system = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        const parsed_error: ?errors.UnsupportedOperationException = aws.json.parseJsonObject(errors.UnsupportedOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedParameterType")) {
        const parsed_error: ?errors.UnsupportedParameterType = aws.json.parseJsonObject(errors.UnsupportedParameterType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_parameter_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedPlatformType")) {
        const parsed_error: ?errors.UnsupportedPlatformType = aws.json.parseJsonObject(errors.UnsupportedPlatformType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_platform_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
