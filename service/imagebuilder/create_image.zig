const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageScanningConfiguration = @import("image_scanning_configuration.zig").ImageScanningConfiguration;
const ImageTestsConfiguration = @import("image_tests_configuration.zig").ImageTestsConfiguration;
const ImageLoggingConfiguration = @import("image_logging_configuration.zig").ImageLoggingConfiguration;
const WorkflowConfiguration = @import("workflow_configuration.zig").WorkflowConfiguration;
const LatestVersionReferences = @import("latest_version_references.zig").LatestVersionReferences;

pub const CreateImageInput = struct {
    /// A unique, case-sensitive identifier you provide to ensure
    /// that the operation runs no more than one time. If you retry a request with
    /// the same client
    /// token, Image Builder returns the original response without running the
    /// operation again. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html)
    /// in the *Amazon EC2 API Reference*.
    client_token: []const u8,

    /// The Amazon Resource Name (ARN) of the container recipe that defines how
    /// images are
    /// configured and tested. You must specify either this property or
    /// `imageRecipeArn`, but not both.
    container_recipe_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the distribution configuration that
    /// defines and
    /// configures the outputs of the image build. If you don't specify a
    /// distribution configuration, Image Builder creates the output image only in
    /// the
    /// account and Amazon Web Services Region where the build runs.
    distribution_configuration_arn: ?[]const u8 = null,

    /// Specifies whether to collect additional information about the image being
    /// created, including the operating
    /// system (OS) version and package list. Defaults to `true`.
    enhanced_image_metadata_enabled: ?bool = null,

    /// The name or Amazon Resource Name (ARN) for the IAM role you create that
    /// grants
    /// Image Builder access to perform workflow actions. This property is required
    /// if you
    /// specify `workflows`. If you don't provide a role, Image Builder uses the
    /// Image Builder service-linked role in your account, and creates it if it
    /// doesn't
    /// exist.
    execution_role: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the image recipe that defines how images
    /// are
    /// configured, tested, and assessed. You must specify either this property or
    /// `containerRecipeArn`, but not both.
    image_recipe_arn: ?[]const u8 = null,

    /// Settings for vulnerability scans that Amazon Inspector runs during image
    /// creation. For AMI output, Amazon Inspector scans the test instance. For
    /// container
    /// output, Amazon Inspector scans the container image that Image Builder pushes
    /// to the Amazon ECR
    /// repository specified in `ecrConfiguration`.
    image_scanning_configuration: ?ImageScanningConfiguration = null,

    /// Settings that determine whether Image Builder runs tests on the image after
    /// building it. Image tests are enabled by default.
    image_tests_configuration: ?ImageTestsConfiguration = null,

    /// The Amazon Resource Name (ARN) of the infrastructure configuration that
    /// defines the
    /// environment in which your image will be built and tested.
    infrastructure_configuration_arn: []const u8,

    /// The CloudWatch Logs log group where Image Builder sends the image build
    /// logs. If
    /// you specify a log group name outside of the `/aws/imagebuilder/`
    /// namespace, you must also provide an `executionRole` that has
    /// permission to write to that log group.
    logging_configuration: ?ImageLoggingConfiguration = null,

    /// The tags of the image.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The array of workflow configuration objects for the build. If you specify
    /// workflows, they replace the default workflows that Image Builder otherwise
    /// runs for
    /// the build, and you must also provide an `executionRole`.
    workflows: ?[]const WorkflowConfiguration = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .container_recipe_arn = "containerRecipeArn",
        .distribution_configuration_arn = "distributionConfigurationArn",
        .enhanced_image_metadata_enabled = "enhancedImageMetadataEnabled",
        .execution_role = "executionRole",
        .image_recipe_arn = "imageRecipeArn",
        .image_scanning_configuration = "imageScanningConfiguration",
        .image_tests_configuration = "imageTestsConfiguration",
        .infrastructure_configuration_arn = "infrastructureConfigurationArn",
        .logging_configuration = "loggingConfiguration",
        .tags = "tags",
        .workflows = "workflows",
    };
};

pub const CreateImageOutput = struct {
    /// The client token that uniquely identifies the request.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the image that the request created.
    image_build_version_arn: ?[]const u8 = null,

    /// A set of wildcard version ARNs that always reference the latest
    /// version of the resource. ARNs are included for the latest version overall,
    /// and for the latest
    /// versions within the same major, minor, and patch levels.
    latest_version_references: ?LatestVersionReferences = null,

    /// The request ID that uniquely identifies this request.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .image_build_version_arn = "imageBuildVersionArn",
        .latest_version_references = "latestVersionReferences",
        .request_id = "requestId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateImageInput, options: CallOptions) !CreateImageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateImage";

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
    if (input.distribution_configuration_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"distributionConfigurationArn\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateImageOutput {
    const result: CreateImageOutput = try aws.json.parseJsonObject(
        CreateImageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
