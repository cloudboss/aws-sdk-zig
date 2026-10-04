const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowType = @import("workflow_type.zig").WorkflowType;
const LatestVersionReferences = @import("latest_version_references.zig").LatestVersionReferences;

pub const CreateWorkflowInput = struct {
    /// Describes what change has been made in this version of the workflow, or
    /// what makes this version different from other versions of the workflow.
    change_description: ?[]const u8 = null,

    /// A unique, case-sensitive identifier you provide to ensure
    /// that the operation runs no more than one time. If you retry a request with
    /// the same client
    /// token, Image Builder returns the original response without running the
    /// operation again. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html)
    /// in the *Amazon EC2 API Reference*.
    client_token: []const u8,

    /// The UTF-8 encoded YAML document content for the workflow, up to
    /// 16,000 characters. For larger documents, store the document in Amazon S3 and
    /// specify
    /// the `uri` property instead. You must specify exactly one of the
    /// `data` or `uri` properties.
    data: ?[]const u8 = null,

    /// Describes the workflow.
    description: ?[]const u8 = null,

    /// Validates the required permissions and request parameters without performing
    /// the operation. If validation succeeds, the operation returns a
    /// `DryRunOperationException` error response.
    dry_run: ?bool = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the KMS key used to
    /// encrypt this workflow resource.
    /// This can be either the Key ARN or the Alias ARN. For more information, see
    /// [Key identifiers
    /// (KeyId)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)
    /// in the *Key Management Service Developer Guide*. If you don't specify a key,
    /// Image Builder encrypts the workflow
    /// document with a KMS key that Image Builder owns.
    kms_key_id: ?[]const u8 = null,

    /// The name of the workflow to create. Image Builder generates the workflow ARN
    /// from a
    /// normalized form of the name, so names that differ only in case, spaces, or
    /// underscores count as the same name. If a workflow with the same name and
    /// semantic version already exists in your account in the same Amazon Web
    /// Services Region,
    /// the request creates a new build version for it. If the content is also
    /// identical to the latest build version, the request fails because the
    /// workflow already exists.
    name: []const u8,

    /// The semantic version of this workflow resource. The semantic version syntax
    /// adheres to the following rules.
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

    /// Tags that apply to the workflow resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The image creation stage that this workflow applies to. Image Builder
    /// validates the
    /// workflow document steps against the stage you specify.
    @"type": WorkflowType,

    /// The `uri` of a YAML workflow document file stored in Amazon S3. This must
    /// be an S3 URL (`s3://bucket/key`), and you must have permission to
    /// access the S3 bucket it points to. A workflow document that you provide from
    /// Amazon S3 can be up to your service quota for workflow size.
    ///
    /// Alternatively, you can specify the YAML document inline, using the workflow
    /// `data` property. You must specify exactly one of the `data`
    /// or `uri` properties.
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .change_description = "changeDescription",
        .client_token = "clientToken",
        .data = "data",
        .description = "description",
        .dry_run = "dryRun",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .semantic_version = "semanticVersion",
        .tags = "tags",
        .@"type" = "type",
        .uri = "uri",
    };
};

pub const CreateWorkflowOutput = struct {
    /// The client token that uniquely identifies the request.
    client_token: ?[]const u8 = null,

    /// A set of wildcard version ARNs that always reference the latest
    /// version of the resource. ARNs are included for the latest version overall,
    /// and for the latest
    /// versions within the same major, minor, and patch levels.
    latest_version_references: ?LatestVersionReferences = null,

    /// The Amazon Resource Name (ARN) of the workflow resource that the request
    /// created.
    workflow_build_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .latest_version_references = "latestVersionReferences",
        .workflow_build_version_arn = "workflowBuildVersionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkflowInput, options: CallOptions) !CreateWorkflowOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateWorkflow";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.change_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"changeDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.data) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"data\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dryRun\":");
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
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;
    if (input.uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"uri\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkflowOutput {
    const result: CreateWorkflowOutput = try aws.json.parseJsonObject(
        CreateWorkflowOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
