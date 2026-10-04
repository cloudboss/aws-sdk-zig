const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComponentConfiguration = @import("component_configuration.zig").ComponentConfiguration;
const VersionCreatedBySource = @import("version_created_by_source.zig").VersionCreatedBySource;

pub const CreateConfigurationBundleInput = struct {
    /// The branch name for version tracking. Defaults to `mainline` if not
    /// specified.
    branch_name: ?[]const u8 = null,

    /// The name for the configuration bundle. Names must be unique within your
    /// account.
    bundle_name: []const u8,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// A commit message describing the initial version of the configuration bundle.
    commit_message: ?[]const u8 = null,

    /// A map of component identifiers to their configurations. Each component
    /// represents a configurable element within the bundle.
    components: []const aws.map.MapEntry(ComponentConfiguration),

    /// The source that created this version, including the source name and optional
    /// ARN.
    created_by: ?VersionCreatedBySource = null,

    /// The description for the configuration bundle.
    description: ?[]const u8 = null,

    /// Optional KMS key ARN for encrypting component configurations.
    kms_key_arn: ?[]const u8 = null,

    /// A map of tag keys and values to assign to the configuration bundle. Tags
    /// enable you to categorize your resources in different ways, for example, by
    /// purpose, owner, or environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .branch_name = "branchName",
        .bundle_name = "bundleName",
        .client_token = "clientToken",
        .commit_message = "commitMessage",
        .components = "components",
        .created_by = "createdBy",
        .description = "description",
        .kms_key_arn = "kmsKeyArn",
        .tags = "tags",
    };
};

pub const CreateConfigurationBundleOutput = struct {
    /// The Amazon Resource Name (ARN) of the created configuration bundle.
    bundle_arn: []const u8,

    /// The unique identifier of the created configuration bundle.
    bundle_id: []const u8,

    /// The timestamp when the configuration bundle was created.
    created_at: i64,

    /// The initial version identifier of the configuration bundle.
    version_id: []const u8,

    pub const json_field_names = .{
        .bundle_arn = "bundleArn",
        .bundle_id = "bundleId",
        .created_at = "createdAt",
        .version_id = "versionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConfigurationBundleInput, options: CallOptions) !CreateConfigurationBundleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConfigurationBundleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configuration-bundles/create";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.branch_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"branchName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"bundleName\":");
    try aws.json.writeValue(@TypeOf(input.bundle_name), input.bundle_name, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.commit_message) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"commitMessage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"components\":");
    try aws.json.writeValue(@TypeOf(input.components), input.components, allocator, &body_buf);
    has_prev = true;
    if (input.created_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"createdBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConfigurationBundleOutput {
    const result: CreateConfigurationBundleOutput = try aws.json.parseJsonObject(
        CreateConfigurationBundleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
