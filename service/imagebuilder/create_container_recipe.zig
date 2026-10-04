const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComponentConfiguration = @import("component_configuration.zig").ComponentConfiguration;
const ContainerType = @import("container_type.zig").ContainerType;
const InstanceConfiguration = @import("instance_configuration.zig").InstanceConfiguration;
const Platform = @import("platform.zig").Platform;
const TargetContainerRepository = @import("target_container_repository.zig").TargetContainerRepository;
const LatestVersionReferences = @import("latest_version_references.zig").LatestVersionReferences;

pub const CreateContainerRecipeInput = struct {
    /// A unique, case-sensitive identifier you provide to ensure
    /// that the operation runs no more than one time. If you retry a request with
    /// the same client
    /// token, Image Builder returns the original response without running the
    /// operation again. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html)
    /// in the *Amazon EC2 API Reference*.
    client_token: []const u8,

    /// The components included in the container recipe. You can specify each
    /// component only one time in a recipe.
    components: ?[]const ComponentConfiguration = null,

    /// The type of container to create.
    container_type: ContainerType,

    /// The description of the container recipe.
    description: ?[]const u8 = null,

    /// The Dockerfile template used to build your image, as an inline data blob.
    /// You must specify exactly one of the `dockerfileTemplateData` or
    /// `dockerfileTemplateUri` properties. For the contextual variables
    /// that the template can include, see [Create
    /// a new version of a container
    /// recipe](https://docs.aws.amazon.com/imagebuilder/latest/userguide/create-container-recipes.html) in the
    /// *EC2 Image Builder User Guide*.
    dockerfile_template_data: ?[]const u8 = null,

    /// The Amazon S3 URI for the Dockerfile template that is used to build your
    /// container
    /// image. You must have permission to read the object. Image Builder reads the
    /// object
    /// once, when it creates the recipe, and stores its content in the recipe.
    /// Later changes to the S3 object don't affect the recipe. You must specify
    /// exactly one of the `dockerfileTemplateData` or
    /// `dockerfileTemplateUri` properties.
    dockerfile_template_uri: ?[]const u8 = null,

    /// Validates the required permissions and request parameters without performing
    /// the operation. If validation succeeds, the operation returns a
    /// `DryRunOperationException` error response.
    dry_run: ?bool = null,

    /// Specifies the operating system version for the base image. Use this property
    /// only when the base image is a container image from a registry. When the base
    /// image is an Image Builder image, the operating system version comes from the
    /// parent
    /// image.
    image_os_version_override: ?[]const u8 = null,

    /// A group of options that can be used to configure an instance for building
    /// and testing
    /// container images.
    instance_configuration: ?InstanceConfiguration = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies which KMS key is
    /// used to encrypt the Dockerfile
    /// template. This can be either the Key ARN or the Alias ARN. For more
    /// information, see [Key identifiers
    /// (KeyId)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)
    /// in the *Key Management Service Developer Guide*.
    kms_key_id: ?[]const u8 = null,

    /// The name of the container recipe. The recipe name, combined with the
    /// semantic version, must be unique to your account in each Amazon Web Services
    /// Region.
    /// Image Builder generates the container recipe ARN from a normalized form of
    /// the
    /// name, so names that differ only in case, spaces, or underscores count as
    /// the same name.
    name: []const u8,

    /// The base image for the container recipe. This can be an Image Builder image
    /// resource
    /// ARN or a container image URI from a registry, for example
    /// `amazonlinux:latest`.
    parent_image: []const u8,

    /// Specifies the operating system platform when you use a custom base image.
    /// Container recipes support only the Linux and Windows platforms.
    platform_override: ?Platform = null,

    /// The semantic version of the container recipe. This version follows the
    /// semantic
    /// version syntax.
    ///
    /// The semantic version has four nodes: ../.
    /// You can assign values for the first three, and can filter on all of them.
    ///
    /// **Assignment:** For the first three nodes, you can assign any positive
    /// integer value, including
    /// zero. The upper limit is 2^30-1, or 1073741823, for each node. Image Builder
    /// automatically assigns the
    /// build number to the fourth node.
    ///
    /// **Patterns:** You can use any numeric pattern that adheres to the assignment
    /// requirements for
    /// the nodes that you can assign. For example, you might choose a software
    /// version pattern, such as 1.0.0, or
    /// a date, such as 2021.01.01.
    semantic_version: []const u8,

    /// Tags that are attached to the container recipe.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The destination repository for the container image. The Amazon ECR
    /// repository
    /// must already exist in the Amazon Web Services Region where the build runs.
    target_repository: TargetContainerRepository,

    /// The working directory for use during build and test workflows.
    working_directory: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .components = "components",
        .container_type = "containerType",
        .description = "description",
        .dockerfile_template_data = "dockerfileTemplateData",
        .dockerfile_template_uri = "dockerfileTemplateUri",
        .dry_run = "dryRun",
        .image_os_version_override = "imageOsVersionOverride",
        .instance_configuration = "instanceConfiguration",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .parent_image = "parentImage",
        .platform_override = "platformOverride",
        .semantic_version = "semanticVersion",
        .tags = "tags",
        .target_repository = "targetRepository",
        .working_directory = "workingDirectory",
    };
};

pub const CreateContainerRecipeOutput = struct {
    /// The client token that uniquely identifies the request.
    client_token: ?[]const u8 = null,

    /// Returns the Amazon Resource Name (ARN) of the container recipe that the
    /// request
    /// created.
    container_recipe_arn: ?[]const u8 = null,

    /// A set of wildcard version ARNs that always reference the latest
    /// version of the resource. ARNs are included for the latest version overall,
    /// and for the latest
    /// versions within the same major, minor, and patch levels.
    latest_version_references: ?LatestVersionReferences = null,

    /// The request ID that uniquely identifies this request.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .container_recipe_arn = "containerRecipeArn",
        .latest_version_references = "latestVersionReferences",
        .request_id = "requestId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateContainerRecipeInput, options: CallOptions) !CreateContainerRecipeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateContainerRecipeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateContainerRecipe";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.components) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"components\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"containerType\":");
    try aws.json.writeValue(@TypeOf(input.container_type), input.container_type, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dockerfile_template_data) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dockerfileTemplateData\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dockerfile_template_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dockerfileTemplateUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dryRun\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.image_os_version_override) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"imageOsVersionOverride\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.instance_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"instanceConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"parentImage\":");
    try aws.json.writeValue(@TypeOf(input.parent_image), input.parent_image, allocator, &body_buf);
    has_prev = true;
    if (input.platform_override) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"platformOverride\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"semanticVersion\":");
    try aws.json.writeValue(@TypeOf(input.semantic_version), input.semantic_version, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetRepository\":");
    try aws.json.writeValue(@TypeOf(input.target_repository), input.target_repository, allocator, &body_buf);
    has_prev = true;
    if (input.working_directory) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workingDirectory\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateContainerRecipeOutput {
    const result: CreateContainerRecipeOutput = try aws.json.parseJsonObject(
        CreateContainerRecipeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
