const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageScanningConfiguration = @import("image_scanning_configuration.zig").ImageScanningConfiguration;
const ImageTestsConfiguration = @import("image_tests_configuration.zig").ImageTestsConfiguration;
const PipelineLoggingConfiguration = @import("pipeline_logging_configuration.zig").PipelineLoggingConfiguration;
const Schedule = @import("schedule.zig").Schedule;
const PipelineStatus = @import("pipeline_status.zig").PipelineStatus;
const WorkflowConfiguration = @import("workflow_configuration.zig").WorkflowConfiguration;

pub const CreateImagePipelineInput = struct {
    /// A unique, case-sensitive identifier you provide to ensure
    /// that the operation runs no more than one time. If you retry a request with
    /// the same client
    /// token, Image Builder returns the original response without running the
    /// operation again. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html)
    /// in the *Amazon EC2 API Reference*.
    client_token: []const u8,

    /// The Amazon Resource Name (ARN) of the container recipe that is used to
    /// configure
    /// images created by this container pipeline. You must specify either this
    /// property or `imageRecipeArn`, but not both.
    container_recipe_arn: ?[]const u8 = null,

    /// The description of the image pipeline.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the distribution configuration that
    /// configures and
    /// distributes images created by this image pipeline.
    distribution_configuration_arn: ?[]const u8 = null,

    /// Validates the required permissions and request parameters without performing
    /// the operation. If validation succeeds, the operation returns a
    /// `DryRunOperationException` error response.
    dry_run: ?bool = null,

    /// Specifies whether to collect additional information about the image being
    /// created, including the operating
    /// system (OS) version and package list. Defaults to `true`.
    enhanced_image_metadata_enabled: ?bool = null,

    /// The name or Amazon Resource Name (ARN) for the IAM role you create that
    /// grants
    /// Image Builder access to perform workflow actions.
    execution_role: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the image recipe that configures
    /// images created by this image pipeline. You must specify either this property
    /// or `containerRecipeArn`, but not both.
    image_recipe_arn: ?[]const u8 = null,

    /// Contains settings for vulnerability scans that Amazon Inspector runs against
    /// the test instance
    /// during image creation.
    image_scanning_configuration: ?ImageScanningConfiguration = null,

    /// The tags that Image Builder applies to the Image Builder image resource that
    /// this
    /// pipeline's scheduled executions create. These tags don't apply to the
    /// output AMI. To tag output AMIs, use `amiTags` in the
    /// pipeline's distribution configuration.
    image_tags: ?[]const aws.map.StringMapEntry = null,

    /// Specifies the test settings that Image Builder applies to images that this
    /// pipeline creates. If you don't provide test settings, Image Builder stores a
    /// default
    /// configuration with image tests enabled.
    image_tests_configuration: ?ImageTestsConfiguration = null,

    /// The Amazon Resource Name (ARN) of the infrastructure configuration that
    /// builds images created by this image pipeline.
    infrastructure_configuration_arn: []const u8,

    /// Specifies the logging configuration for the image pipeline. Use this
    /// to define custom CloudWatch Logs log groups for your pipeline execution
    /// logs and image build logs. The service manages log groups with names
    /// starting with `/aws/imagebuilder/` using the service-linked
    /// role. For custom log group names outside of this prefix, you must also
    /// provide an `executionRole`.
    logging_configuration: ?PipelineLoggingConfiguration = null,

    /// The name of the image pipeline. Pipeline names must be unique to your
    /// account in each Amazon Web Services Region. Image Builder generates the
    /// pipeline ARN from a
    /// normalized form of the name, so names that differ only in case, spaces, or
    /// underscores count as the same name.
    name: []const u8,

    /// The schedule of the image pipeline. If you don't provide a schedule, the
    /// pipeline runs only when you call
    /// StartImagePipelineExecution.
    schedule: ?Schedule = null,

    /// The status of the image pipeline. If you don't specify a status, it
    /// defaults to `ENABLED`. A disabled pipeline doesn't run on its
    /// schedule, but you can still start builds manually.
    status: ?PipelineStatus = null,

    /// The tags of the image pipeline.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The array of workflow configuration objects for builds that this pipeline
    /// starts. You must also specify `executionRole` when you provide
    /// workflows.
    workflows: ?[]const WorkflowConfiguration = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .container_recipe_arn = "containerRecipeArn",
        .description = "description",
        .distribution_configuration_arn = "distributionConfigurationArn",
        .dry_run = "dryRun",
        .enhanced_image_metadata_enabled = "enhancedImageMetadataEnabled",
        .execution_role = "executionRole",
        .image_recipe_arn = "imageRecipeArn",
        .image_scanning_configuration = "imageScanningConfiguration",
        .image_tags = "imageTags",
        .image_tests_configuration = "imageTestsConfiguration",
        .infrastructure_configuration_arn = "infrastructureConfigurationArn",
        .logging_configuration = "loggingConfiguration",
        .name = "name",
        .schedule = "schedule",
        .status = "status",
        .tags = "tags",
        .workflows = "workflows",
    };
};

pub const CreateImagePipelineOutput = struct {
    /// The client token that uniquely identifies the request.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the image pipeline that was created by
    /// this
    /// request.
    image_pipeline_arn: ?[]const u8 = null,

    /// The request ID that uniquely identifies this request.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .image_pipeline_arn = "imagePipelineArn",
        .request_id = "requestId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateImagePipelineInput, options: CallOptions) !CreateImagePipelineOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "imagebuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateImagePipelineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateImagePipeline";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.container_recipe_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"containerRecipeArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.distribution_configuration_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"distributionConfigurationArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dryRun\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enhanced_image_metadata_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enhancedImageMetadataEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.execution_role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionRole\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.image_recipe_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"imageRecipeArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.image_scanning_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"imageScanningConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.image_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"imageTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.image_tests_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"imageTestsConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"infrastructureConfigurationArn\":");
    try aws.json.writeValue(@TypeOf(input.infrastructure_configuration_arn), input.infrastructure_configuration_arn, allocator, &body_buf);
    has_prev = true;
    if (input.logging_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"loggingConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.schedule) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"schedule\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workflows) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workflows\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateImagePipelineOutput {
    const result: CreateImagePipelineOutput = try aws.json.parseJsonObject(
        CreateImagePipelineOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
