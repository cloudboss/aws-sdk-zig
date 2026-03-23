const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ArtifactConfigInput = @import("artifact_config_input.zig").ArtifactConfigInput;
const BrowserConfig = @import("browser_config.zig").BrowserConfig;
const CanaryCodeInput = @import("canary_code_input.zig").CanaryCodeInput;
const ProvisionedResourceCleanupSetting = @import("provisioned_resource_cleanup_setting.zig").ProvisionedResourceCleanupSetting;
const ResourceToTag = @import("resource_to_tag.zig").ResourceToTag;
const CanaryRunConfigInput = @import("canary_run_config_input.zig").CanaryRunConfigInput;
const CanaryScheduleInput = @import("canary_schedule_input.zig").CanaryScheduleInput;
const VpcConfigInput = @import("vpc_config_input.zig").VpcConfigInput;
const Canary = @import("canary.zig").Canary;

pub const CreateCanaryInput = struct {
    /// A structure that contains the configuration for canary artifacts, including
    /// the encryption-at-rest settings for artifacts that the canary uploads to
    /// Amazon S3.
    artifact_config: ?ArtifactConfigInput = null,

    /// The location in Amazon S3 where Synthetics stores artifacts from the test
    /// runs of this
    /// canary. Artifacts include the log file, screenshots, and HAR files. The name
    /// of the
    /// Amazon S3 bucket can't include a period (.).
    artifact_s3_location: []const u8,

    /// CloudWatch Synthetics now supports multibrowser canaries for
    /// `syn-nodejs-puppeteer-11.0` and `syn-nodejs-playwright-3.0` runtimes. This
    /// feature allows you to run your canaries on both
    /// Firefox and Chrome browsers. To create a multibrowser canary, you need to
    /// specify the BrowserConfigs with a list of browsers you want to use.
    ///
    /// If not specified, `browserConfigs` defaults to Chrome.
    browser_configs: ?[]const BrowserConfig = null,

    /// A structure that includes the entry point from which the canary should start
    /// running your script. If the script is stored in
    /// an Amazon S3 bucket, the bucket name, key, and version are also included.
    code: CanaryCodeInput,

    /// The ARN of the IAM role to be used to run the canary. This role must already
    /// exist,
    /// and must include `lambda.amazonaws.com` as a principal in the trust
    /// policy. The role must also have the following permissions:
    ///
    /// * `s3:PutObject`
    ///
    /// * `s3:GetBucketLocation`
    ///
    /// * `s3:ListAllMyBuckets`
    ///
    /// * `cloudwatch:PutMetricData`
    ///
    /// * `logs:CreateLogGroup`
    ///
    /// * `logs:CreateLogStream`
    ///
    /// * `logs:PutLogEvents`
    execution_role_arn: []const u8,

    /// The number of days to retain data about failed runs of this canary. If you
    /// omit
    /// this field, the default of 31 days is used. The valid range is 1 to 455
    /// days.
    ///
    /// This setting affects the range of information returned by
    /// [GetCanaryRuns](https://docs.aws.amazon.com/AmazonSynthetics/latest/APIReference/API_GetCanaryRuns.html), as well as
    /// the range of information displayed in the Synthetics console.
    failure_retention_period_in_days: ?i32 = null,

    /// The name for this canary. Be sure to give it a descriptive name
    /// that distinguishes it from other canaries in your account.
    ///
    /// Do not include secrets or proprietary information in your canary names. The
    /// canary name
    /// makes up part of the canary ARN, and the ARN is included in outbound calls
    /// over the
    /// internet. For more information, see [Security
    /// Considerations for Synthetics
    /// Canaries](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/servicelens_canaries_security.html).
    name: []const u8,

    /// Specifies whether to also delete the Lambda functions and layers used by
    /// this canary
    /// when the canary is deleted. If you omit this parameter, the default of
    /// `AUTOMATIC` is used, which means
    /// that the Lambda functions and layers will be deleted when the canary is
    /// deleted.
    ///
    /// If the value of this parameter is `OFF`, then the value of the
    /// `DeleteLambda` parameter
    /// of the
    /// [DeleteCanary](https://docs.aws.amazon.com/AmazonSynthetics/latest/APIReference/API_DeleteCanary.html) operation
    /// determines whether the Lambda functions and layers will be deleted.
    provisioned_resource_cleanup: ?ProvisionedResourceCleanupSetting = null,

    /// To have the tags that you apply to this canary also be applied to the Lambda
    /// function that
    /// the canary uses, specify this parameter with the value `lambda-function`.
    ///
    /// If you specify this parameter and don't specify any tags in the `Tags`
    /// parameter, the canary creation fails.
    resources_to_replicate_tags: ?[]const ResourceToTag = null,

    /// A structure that contains the configuration for individual canary runs,
    /// such as timeout value and environment variables.
    ///
    /// Environment variable keys and values are encrypted at rest using Amazon Web
    /// Services owned KMS keys. However, the environment variables
    /// are not encrypted on the client side. Do not store sensitive information
    /// in them.
    run_config: ?CanaryRunConfigInput = null,

    /// Specifies the runtime version to use for the canary. For a list of valid
    /// runtime versions and more information about
    /// runtime versions, see [
    /// Canary Runtime
    /// Versions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_Library.html).
    runtime_version: []const u8,

    /// A structure that contains information about how often the canary is to run
    /// and when
    /// these test runs are to stop.
    schedule: CanaryScheduleInput,

    /// The number of days to retain data about successful runs of this canary. If
    /// you omit
    /// this field, the default of 31 days is used. The valid range is 1 to 455
    /// days.
    ///
    /// This setting affects the range of information returned by
    /// [GetCanaryRuns](https://docs.aws.amazon.com/AmazonSynthetics/latest/APIReference/API_GetCanaryRuns.html), as well as
    /// the range of information displayed in the Synthetics console.
    success_retention_period_in_days: ?i32 = null,

    /// A list of key-value pairs to associate with the canary.
    /// You can associate as many as 50 tags with a canary.
    ///
    /// Tags can help you organize and categorize your
    /// resources. You can also use them to scope user permissions, by
    /// granting a user permission to access or change only the resources that have
    /// certain tag values.
    ///
    /// To have the tags that you apply to this canary also be applied to the Lambda
    /// function that
    /// the canary uses, specify this parameter with the value `lambda-function`.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// If this canary is to test an endpoint in a VPC, this structure contains
    /// information about the subnet and security groups of the VPC endpoint.
    /// For more information, see [
    /// Running a Canary in a
    /// VPC](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_VPC.html).
    vpc_config: ?VpcConfigInput = null,

    pub const json_field_names = .{
        .artifact_config = "ArtifactConfig",
        .artifact_s3_location = "ArtifactS3Location",
        .browser_configs = "BrowserConfigs",
        .code = "Code",
        .execution_role_arn = "ExecutionRoleArn",
        .failure_retention_period_in_days = "FailureRetentionPeriodInDays",
        .name = "Name",
        .provisioned_resource_cleanup = "ProvisionedResourceCleanup",
        .resources_to_replicate_tags = "ResourcesToReplicateTags",
        .run_config = "RunConfig",
        .runtime_version = "RuntimeVersion",
        .schedule = "Schedule",
        .success_retention_period_in_days = "SuccessRetentionPeriodInDays",
        .tags = "Tags",
        .vpc_config = "VpcConfig",
    };
};

pub const CreateCanaryOutput = struct {
    /// The full details about the canary you have created.
    canary: ?Canary = null,

    pub const json_field_names = .{
        .canary = "Canary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCanaryInput, options: CallOptions) !CreateCanaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "synthetics");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCanaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("synthetics", "synthetics", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/canary";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.artifact_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ArtifactConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ArtifactS3Location\":");
    try aws.json.writeValue(@TypeOf(input.artifact_s3_location), input.artifact_s3_location, allocator, &body_buf);
    has_prev = true;
    if (input.browser_configs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BrowserConfigs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Code\":");
    try aws.json.writeValue(@TypeOf(input.code), input.code, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ExecutionRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.execution_role_arn), input.execution_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.failure_retention_period_in_days) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FailureRetentionPeriodInDays\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.provisioned_resource_cleanup) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ProvisionedResourceCleanup\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resources_to_replicate_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourcesToReplicateTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.run_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RunConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RuntimeVersion\":");
    try aws.json.writeValue(@TypeOf(input.runtime_version), input.runtime_version, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Schedule\":");
    try aws.json.writeValue(@TypeOf(input.schedule), input.schedule, allocator, &body_buf);
    has_prev = true;
    if (input.success_retention_period_in_days) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SuccessRetentionPeriodInDays\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VpcConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCanaryOutput {
    var result: CreateCanaryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCanaryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestEntityTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .request_entity_too_large_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
