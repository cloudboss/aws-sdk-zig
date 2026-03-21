const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EnhancedInfrastructureMetrics = @import("enhanced_infrastructure_metrics.zig").EnhancedInfrastructureMetrics;
const ExternalMetricsPreference = @import("external_metrics_preference.zig").ExternalMetricsPreference;
const InferredWorkloadTypesPreference = @import("inferred_workload_types_preference.zig").InferredWorkloadTypesPreference;
const LookBackPeriodPreference = @import("look_back_period_preference.zig").LookBackPeriodPreference;
const PreferredResource = @import("preferred_resource.zig").PreferredResource;
const ResourceType = @import("resource_type.zig").ResourceType;
const SavingsEstimationMode = @import("savings_estimation_mode.zig").SavingsEstimationMode;
const Scope = @import("scope.zig").Scope;
const UtilizationPreference = @import("utilization_preference.zig").UtilizationPreference;

pub const PutRecommendationPreferencesInput = struct {
    /// The status of the enhanced infrastructure metrics recommendation preference
    /// to create
    /// or update.
    ///
    /// Specify the `Active` status to activate the preference, or specify
    /// `Inactive` to deactivate the preference.
    ///
    /// For more information, see [Enhanced
    /// infrastructure
    /// metrics](https://docs.aws.amazon.com/compute-optimizer/latest/ug/enhanced-infrastructure-metrics.html) in the *Compute Optimizer User
    /// Guide*.
    enhanced_infrastructure_metrics: ?EnhancedInfrastructureMetrics = null,

    /// The provider of the external metrics recommendation preference to create or
    /// update.
    ///
    /// Specify a valid provider in the `source` field to activate the preference.
    /// To delete this preference, see the DeleteRecommendationPreferences
    /// action.
    ///
    /// This preference can only be set for the `Ec2Instance` resource type.
    ///
    /// For more information, see [External metrics
    /// ingestion](https://docs.aws.amazon.com/compute-optimizer/latest/ug/external-metrics-ingestion.html) in the *Compute Optimizer User
    /// Guide*.
    external_metrics_preference: ?ExternalMetricsPreference = null,

    /// The status of the inferred workload types recommendation preference to
    /// create or
    /// update.
    ///
    /// The inferred workload type feature is active by default. To deactivate it,
    /// create
    /// a recommendation preference.
    ///
    /// Specify the `Inactive` status to deactivate the feature, or specify
    /// `Active` to activate it.
    ///
    /// For more information, see [Inferred workload
    /// types](https://docs.aws.amazon.com/compute-optimizer/latest/ug/inferred-workload-types.html) in the *Compute Optimizer User Guide*.
    inferred_workload_types: ?InferredWorkloadTypesPreference = null,

    /// The preference to control the number of days the utilization metrics of the
    /// Amazon Web Services resource are analyzed.
    /// When this preference isn't specified, we use the default value `DAYS_14`.
    ///
    /// You can only set this preference for the Amazon EC2 instance and Amazon EC2
    /// Auto Scaling group resource types.
    ///
    /// * Amazon EC2 instance lookback preferences can be set at the organization,
    ///   account, and resource levels.
    ///
    /// * Amazon EC2 Auto Scaling group lookback preferences can only be set at the
    ///   resource level.
    look_back_period: ?LookBackPeriodPreference = null,

    /// The preference to control which resource type values are considered when
    /// generating rightsizing recommendations.
    /// You can specify this preference as a combination of include and exclude
    /// lists. You must specify either an
    /// `includeList` or `excludeList`. If the preference is an empty set of
    /// resource type values,
    /// an error occurs.
    ///
    /// You can only set this preference for the Amazon EC2 instance and Amazon EC2
    /// Auto Scaling group resource types.
    preferred_resources: ?[]const PreferredResource = null,

    /// The target resource type of the recommendation preference to create.
    ///
    /// The `Ec2Instance` option encompasses standalone instances and instances
    /// that are part of Amazon EC2 Auto Scaling groups. The `AutoScalingGroup`
    /// option
    /// encompasses only instances that are part of an Amazon EC2 Auto Scaling
    /// group.
    resource_type: ResourceType,

    /// The status of the savings estimation mode preference to create or update.
    ///
    /// Specify the `AfterDiscounts` status to activate the preference, or specify
    /// `BeforeDiscounts` to deactivate the preference.
    ///
    /// Only the account manager or delegated administrator of your organization can
    /// activate this preference.
    ///
    /// For more information, see [
    /// Savings estimation
    /// mode](https://docs.aws.amazon.com/compute-optimizer/latest/ug/savings-estimation-mode.html) in the *Compute Optimizer User Guide*.
    savings_estimation_mode: ?SavingsEstimationMode = null,

    /// An object that describes the scope of the recommendation preference to
    /// create.
    ///
    /// You can create recommendation preferences at the organization level (for
    /// management
    /// accounts of an organization only), account level, and resource level. For
    /// more
    /// information, see [Activating
    /// enhanced infrastructure
    /// metrics](https://docs.aws.amazon.com/compute-optimizer/latest/ug/enhanced-infrastructure-metrics.html) in the *Compute Optimizer User
    /// Guide*.
    ///
    /// You cannot create recommendation preferences for Amazon EC2 Auto Scaling
    /// groups at the
    /// organization and account levels. You can create recommendation preferences
    /// for
    /// Amazon EC2 Auto Scaling groups only at the resource level by specifying a
    /// scope name
    /// of `ResourceArn` and a scope value of the Amazon EC2 Auto Scaling group
    /// Amazon
    /// Resource Name (ARN). This will configure the preference for all instances
    /// that are
    /// part of the specified Amazon EC2 Auto Scaling group. You also cannot create
    /// recommendation
    /// preferences at the resource level for instances that are part of an Amazon
    /// EC2 Auto Scaling group. You can create recommendation preferences at the
    /// resource level only for
    /// standalone instances.
    scope: ?Scope = null,

    /// The preference to control the resource’s CPU utilization threshold, CPU
    /// utilization headroom, and memory utilization headroom. When this
    /// preference isn't specified, we use the following default values.
    ///
    /// CPU utilization:
    ///
    /// * `P99_5` for threshold
    ///
    /// * `PERCENT_20` for headroom
    ///
    /// Memory utilization:
    ///
    /// * `PERCENT_20` for headroom
    ///
    /// * You can only set CPU and memory utilization preferences for the Amazon EC2
    ///   instance resource type.
    ///
    /// * The threshold setting isn’t available for memory utilization.
    utilization_preferences: ?[]const UtilizationPreference = null,

    pub const json_field_names = .{
        .enhanced_infrastructure_metrics = "enhancedInfrastructureMetrics",
        .external_metrics_preference = "externalMetricsPreference",
        .inferred_workload_types = "inferredWorkloadTypes",
        .look_back_period = "lookBackPeriod",
        .preferred_resources = "preferredResources",
        .resource_type = "resourceType",
        .savings_estimation_mode = "savingsEstimationMode",
        .scope = "scope",
        .utilization_preferences = "utilizationPreferences",
    };
};

pub const PutRecommendationPreferencesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRecommendationPreferencesInput, options: CallOptions) !PutRecommendationPreferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "compute-optimizer");

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRecommendationPreferencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("compute-optimizer", "Compute Optimizer", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerService.PutRecommendationPreferences");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRecommendationPreferencesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
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
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingAuthenticationToken")) {
        return .{ .arena = arena, .kind = .{ .missing_authentication_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OptInRequiredException")) {
        return .{ .arena = arena, .kind = .{ .opt_in_required_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
