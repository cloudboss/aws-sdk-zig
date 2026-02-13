const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;
const ParameterTier = @import("parameter_tier.zig").ParameterTier;
const ParameterType = @import("parameter_type.zig").ParameterType;

/// Create or update a parameter in Parameter Store.
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
    /// **Note:**
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
    /// **Important:**
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
    ///
    /// `SecureString` isn't currently supported for CloudFormation templates.
    ///
    /// Items in a `StringList` must be separated by a comma (,). You can't
    /// use other punctuation or special character to escape items in the list. If
    /// you have a parameter
    /// value that requires a comma, then use the `String` data type.
    ///
    /// **Important:**
    ///
    /// Specifying a parameter type isn't required when updating a parameter. You
    /// must specify a
    /// parameter type when creating a parameter.
    @"type": ?ParameterType = null,

    /// The parameter value that you want to add to the system. Standard parameters
    /// have a value
    /// limit of 4 KB. Advanced parameters have a value limit of 8 KB.
    ///
    /// **Note:**
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *PutParameterOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .tier = "Tier",
        .version = "Version",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: PutParameterInput, options: Options) !PutParameterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ssm");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: PutParameterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ssm", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonSSM.PutParameter");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutParameterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutParameterOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .access_denied_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AssociatedInstances")) {
        return .{ .associated_instances = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AssociationAlreadyExists")) {
        return .{ .association_already_exists = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AssociationDoesNotExist")) {
        return .{ .association_does_not_exist = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AssociationExecutionDoesNotExist")) {
        return .{ .association_execution_does_not_exist = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AssociationLimitExceeded")) {
        return .{ .association_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AssociationVersionLimitExceeded")) {
        return .{ .association_version_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionNotApprovedException")) {
        return .{ .automation_definition_not_approved_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionNotFoundException")) {
        return .{ .automation_definition_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionVersionNotFoundException")) {
        return .{ .automation_definition_version_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AutomationExecutionLimitExceededException")) {
        return .{ .automation_execution_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AutomationExecutionNotFoundException")) {
        return .{ .automation_execution_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "AutomationStepNotFoundException")) {
        return .{ .automation_step_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ComplianceTypeCountLimitExceededException")) {
        return .{ .compliance_type_count_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "CustomSchemaCountLimitExceededException")) {
        return .{ .custom_schema_count_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DocumentAlreadyExists")) {
        return .{ .document_already_exists = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DocumentLimitExceeded")) {
        return .{ .document_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DocumentPermissionLimit")) {
        return .{ .document_permission_limit = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DocumentVersionLimitExceeded")) {
        return .{ .document_version_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DoesNotExistException")) {
        return .{ .does_not_exist_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateDocumentContent")) {
        return .{ .duplicate_document_content = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateDocumentVersionName")) {
        return .{ .duplicate_document_version_name = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateInstanceId")) {
        return .{ .duplicate_instance_id = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "FeatureNotAvailableException")) {
        return .{ .feature_not_available_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "HierarchyLevelLimitExceededException")) {
        return .{ .hierarchy_level_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "HierarchyTypeMismatchException")) {
        return .{ .hierarchy_type_mismatch_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatch")) {
        return .{ .idempotent_parameter_mismatch = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "IncompatiblePolicyException")) {
        return .{ .incompatible_policy_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .internal_server_error = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidActivation")) {
        return .{ .invalid_activation = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidActivationId")) {
        return .{ .invalid_activation_id = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAggregatorException")) {
        return .{ .invalid_aggregator_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAllowedPatternException")) {
        return .{ .invalid_allowed_pattern_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAssociation")) {
        return .{ .invalid_association = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAssociationVersion")) {
        return .{ .invalid_association_version = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationExecutionParametersException")) {
        return .{ .invalid_automation_execution_parameters_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationSignalException")) {
        return .{ .invalid_automation_signal_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationStatusUpdateException")) {
        return .{ .invalid_automation_status_update_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCommandId")) {
        return .{ .invalid_command_id = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDeleteInventoryParametersException")) {
        return .{ .invalid_delete_inventory_parameters_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDeletionIdException")) {
        return .{ .invalid_deletion_id_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocument")) {
        return .{ .invalid_document = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentContent")) {
        return .{ .invalid_document_content = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentOperation")) {
        return .{ .invalid_document_operation = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentSchemaVersion")) {
        return .{ .invalid_document_schema_version = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentType")) {
        return .{ .invalid_document_type = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentVersion")) {
        return .{ .invalid_document_version = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFilter")) {
        return .{ .invalid_filter = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterKey")) {
        return .{ .invalid_filter_key = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterOption")) {
        return .{ .invalid_filter_option = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterValue")) {
        return .{ .invalid_filter_value = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceId")) {
        return .{ .invalid_instance_id = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceInformationFilterValue")) {
        return .{ .invalid_instance_information_filter_value = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInstancePropertyFilterValue")) {
        return .{ .invalid_instance_property_filter_value = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryGroupException")) {
        return .{ .invalid_inventory_group_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryItemContextException")) {
        return .{ .invalid_inventory_item_context_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryRequestException")) {
        return .{ .invalid_inventory_request_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidItemContentException")) {
        return .{ .invalid_item_content_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidKeyId")) {
        return .{ .invalid_key_id = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        return .{ .invalid_next_token = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNotificationConfig")) {
        return .{ .invalid_notification_config = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOptionException")) {
        return .{ .invalid_option_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOutputFolder")) {
        return .{ .invalid_output_folder = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOutputLocation")) {
        return .{ .invalid_output_location = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameters")) {
        return .{ .invalid_parameters = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPermissionType")) {
        return .{ .invalid_permission_type = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPluginName")) {
        return .{ .invalid_plugin_name = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyAttributeException")) {
        return .{ .invalid_policy_attribute_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyTypeException")) {
        return .{ .invalid_policy_type_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceId")) {
        return .{ .invalid_resource_id = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceType")) {
        return .{ .invalid_resource_type = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResultAttributeException")) {
        return .{ .invalid_result_attribute_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRole")) {
        return .{ .invalid_role = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSchedule")) {
        return .{ .invalid_schedule = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTag")) {
        return .{ .invalid_tag = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTarget")) {
        return .{ .invalid_target = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetMaps")) {
        return .{ .invalid_target_maps = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTypeNameException")) {
        return .{ .invalid_type_name_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidUpdate")) {
        return .{ .invalid_update = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvocationDoesNotExist")) {
        return .{ .invocation_does_not_exist = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ItemContentMismatchException")) {
        return .{ .item_content_mismatch_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ItemSizeLimitExceededException")) {
        return .{ .item_size_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "MalformedResourcePolicyDocumentException")) {
        return .{ .malformed_resource_policy_document_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "MaxDocumentSizeExceeded")) {
        return .{ .max_document_size_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "NoLongerSupportedException")) {
        return .{ .no_longer_supported_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemAccessDeniedException")) {
        return .{ .ops_item_access_denied_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemAlreadyExistsException")) {
        return .{ .ops_item_already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemConflictException")) {
        return .{ .ops_item_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemInvalidParameterException")) {
        return .{ .ops_item_invalid_parameter_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemLimitExceededException")) {
        return .{ .ops_item_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemNotFoundException")) {
        return .{ .ops_item_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemRelatedItemAlreadyExistsException")) {
        return .{ .ops_item_related_item_already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsItemRelatedItemAssociationNotFoundException")) {
        return .{ .ops_item_related_item_association_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataAlreadyExistsException")) {
        return .{ .ops_metadata_already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataInvalidArgumentException")) {
        return .{ .ops_metadata_invalid_argument_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataKeyLimitExceededException")) {
        return .{ .ops_metadata_key_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataLimitExceededException")) {
        return .{ .ops_metadata_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataNotFoundException")) {
        return .{ .ops_metadata_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataTooManyUpdatesException")) {
        return .{ .ops_metadata_too_many_updates_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ParameterAlreadyExists")) {
        return .{ .parameter_already_exists = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ParameterLimitExceeded")) {
        return .{ .parameter_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ParameterMaxVersionLimitExceeded")) {
        return .{ .parameter_max_version_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ParameterNotFound")) {
        return .{ .parameter_not_found = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ParameterPatternMismatchException")) {
        return .{ .parameter_pattern_mismatch_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ParameterVersionLabelLimitExceeded")) {
        return .{ .parameter_version_label_limit_exceeded = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ParameterVersionNotFound")) {
        return .{ .parameter_version_not_found = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PoliciesLimitExceededException")) {
        return .{ .policies_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncAlreadyExistsException")) {
        return .{ .resource_data_sync_already_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncConflictException")) {
        return .{ .resource_data_sync_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncCountExceededException")) {
        return .{ .resource_data_sync_count_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncInvalidConfigurationException")) {
        return .{ .resource_data_sync_invalid_configuration_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncNotFoundException")) {
        return .{ .resource_data_sync_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .resource_in_use_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .resource_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyConflictException")) {
        return .{ .resource_policy_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyInvalidParameterException")) {
        return .{ .resource_policy_invalid_parameter_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyLimitExceededException")) {
        return .{ .resource_policy_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyNotFoundException")) {
        return .{ .resource_policy_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .service_quota_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ServiceSettingNotFound")) {
        return .{ .service_setting_not_found = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "StatusUnchanged")) {
        return .{ .status_unchanged = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SubTypeCountLimitExceededException")) {
        return .{ .sub_type_count_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TargetInUseException")) {
        return .{ .target_in_use_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TargetNotConnected")) {
        return .{ .target_not_connected = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .throttling_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsError")) {
        return .{ .too_many_tags_error = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyUpdates")) {
        return .{ .too_many_updates = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TotalSizeLimitExceededException")) {
        return .{ .total_size_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedCalendarException")) {
        return .{ .unsupported_calendar_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedFeatureRequiredException")) {
        return .{ .unsupported_feature_required_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedInventoryItemContextException")) {
        return .{ .unsupported_inventory_item_context_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedInventorySchemaVersionException")) {
        return .{ .unsupported_inventory_schema_version_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperatingSystem")) {
        return .{ .unsupported_operating_system = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .unsupported_operation_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedParameterType")) {
        return .{ .unsupported_parameter_type = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedPlatformType")) {
        return .{ .unsupported_platform_type = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .validation_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = "",
        .http_status = status,
    } };
}
