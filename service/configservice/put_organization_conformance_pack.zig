const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConformancePackInputParameter = @import("conformance_pack_input_parameter.zig").ConformancePackInputParameter;

pub const PutOrganizationConformancePackInput = struct {
    /// A list of `ConformancePackInputParameter` objects.
    conformance_pack_input_parameters: ?[]const ConformancePackInputParameter = null,

    /// The name of the Amazon S3 bucket where Config stores conformance pack
    /// templates.
    ///
    /// This field is optional. If used, it must be prefixed with
    /// `awsconfigconforms`.
    delivery_s3_bucket: ?[]const u8 = null,

    /// The prefix for the Amazon S3 bucket.
    ///
    /// This field is optional.
    delivery_s3_key_prefix: ?[]const u8 = null,

    /// A list of Amazon Web Services accounts to be excluded from an organization
    /// conformance pack while deploying a conformance pack.
    excluded_accounts: ?[]const []const u8 = null,

    /// Name of the organization conformance pack you want to create.
    organization_conformance_pack_name: []const u8,

    /// A string that contains the full conformance pack template body. Structure
    /// containing the template body
    /// with a minimum length of 1 byte and a maximum length of 51,200 bytes.
    template_body: ?[]const u8 = null,

    /// Location of file containing the template body. The uri must point to the
    /// conformance pack template
    /// (max size: 300 KB).
    ///
    /// You must have access to read Amazon S3 bucket.
    /// In addition, in order to ensure a successful deployment, the template object
    /// must not be in an [archived storage
    /// class](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html) if this parameter is passed.
    template_s3_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .conformance_pack_input_parameters = "ConformancePackInputParameters",
        .delivery_s3_bucket = "DeliveryS3Bucket",
        .delivery_s3_key_prefix = "DeliveryS3KeyPrefix",
        .excluded_accounts = "ExcludedAccounts",
        .organization_conformance_pack_name = "OrganizationConformancePackName",
        .template_body = "TemplateBody",
        .template_s3_uri = "TemplateS3Uri",
    };
};

pub const PutOrganizationConformancePackOutput = struct {
    /// ARN of the organization conformance pack.
    organization_conformance_pack_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .organization_conformance_pack_arn = "OrganizationConformancePackArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutOrganizationConformancePackInput, options: Options) !PutOrganizationConformancePackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "configservice");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: PutOrganizationConformancePackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("configservice", "Config Service", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "StarlingDoveService.PutOrganizationConformancePack");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutOrganizationConformancePackOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutOrganizationConformancePackOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConformancePackTemplateValidationException")) {
        return .{ .arena = arena, .kind = .{ .conformance_pack_template_validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatch")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientDeliveryPolicyException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_delivery_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientPermissionsException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_permissions_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidConfigurationRecorderNameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_configuration_recorder_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDeliveryChannelNameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_delivery_channel_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidExpressionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_expression_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLimitException")) {
        return .{ .arena = arena, .kind = .{ .invalid_limit_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRecordingGroupException")) {
        return .{ .arena = arena, .kind = .{ .invalid_recording_group_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResultTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_result_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRoleException")) {
        return .{ .arena = arena, .kind = .{ .invalid_role_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3KeyPrefixException")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_key_prefix_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3KmsKeyArnException")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_kms_key_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSNSTopicARNException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sns_topic_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTimeRangeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_time_range_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LastDeliveryChannelDeleteFailedException")) {
        return .{ .arena = arena, .kind = .{ .last_delivery_channel_delete_failed_exception = .{
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
    if (std.mem.eql(u8, error_code, "MaxActiveResourcesExceededException")) {
        return .{ .arena = arena, .kind = .{ .max_active_resources_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfConfigRulesExceededException")) {
        return .{ .arena = arena, .kind = .{ .max_number_of_config_rules_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfConfigurationRecordersExceededException")) {
        return .{ .arena = arena, .kind = .{ .max_number_of_configuration_recorders_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfConformancePacksExceededException")) {
        return .{ .arena = arena, .kind = .{ .max_number_of_conformance_packs_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfDeliveryChannelsExceededException")) {
        return .{ .arena = arena, .kind = .{ .max_number_of_delivery_channels_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfOrganizationConfigRulesExceededException")) {
        return .{ .arena = arena, .kind = .{ .max_number_of_organization_config_rules_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfOrganizationConformancePacksExceededException")) {
        return .{ .arena = arena, .kind = .{ .max_number_of_organization_conformance_packs_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfRetentionConfigurationsExceededException")) {
        return .{ .arena = arena, .kind = .{ .max_number_of_retention_configurations_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoAvailableConfigurationRecorderException")) {
        return .{ .arena = arena, .kind = .{ .no_available_configuration_recorder_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoAvailableDeliveryChannelException")) {
        return .{ .arena = arena, .kind = .{ .no_available_delivery_channel_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoAvailableOrganizationException")) {
        return .{ .arena = arena, .kind = .{ .no_available_organization_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoRunningConfigurationRecorderException")) {
        return .{ .arena = arena, .kind = .{ .no_running_configuration_recorder_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchBucketException")) {
        return .{ .arena = arena, .kind = .{ .no_such_bucket_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchConfigRuleException")) {
        return .{ .arena = arena, .kind = .{ .no_such_config_rule_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchConfigRuleInConformancePackException")) {
        return .{ .arena = arena, .kind = .{ .no_such_config_rule_in_conformance_pack_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchConfigurationAggregatorException")) {
        return .{ .arena = arena, .kind = .{ .no_such_configuration_aggregator_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchConfigurationRecorderException")) {
        return .{ .arena = arena, .kind = .{ .no_such_configuration_recorder_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchConformancePackException")) {
        return .{ .arena = arena, .kind = .{ .no_such_conformance_pack_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchDeliveryChannelException")) {
        return .{ .arena = arena, .kind = .{ .no_such_delivery_channel_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchOrganizationConfigRuleException")) {
        return .{ .arena = arena, .kind = .{ .no_such_organization_config_rule_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchOrganizationConformancePackException")) {
        return .{ .arena = arena, .kind = .{ .no_such_organization_conformance_pack_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchRemediationConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .no_such_remediation_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchRemediationExceptionException")) {
        return .{ .arena = arena, .kind = .{ .no_such_remediation_exception_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchRetentionConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .no_such_retention_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .organization_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationAllFeaturesNotEnabledException")) {
        return .{ .arena = arena, .kind = .{ .organization_all_features_not_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationConformancePackTemplateValidationException")) {
        return .{ .arena = arena, .kind = .{ .organization_conformance_pack_template_validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OversizedConfigurationItemException")) {
        return .{ .arena = arena, .kind = .{ .oversized_configuration_item_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RemediationInProgressException")) {
        return .{ .arena = arena, .kind = .{ .remediation_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .resource_concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotDiscoveredException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_discovered_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnmodifiableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unmodifiable_entity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
