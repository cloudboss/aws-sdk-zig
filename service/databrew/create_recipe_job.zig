const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatabaseOutput = @import("database_output.zig").DatabaseOutput;
const DataCatalogOutput = @import("data_catalog_output.zig").DataCatalogOutput;
const EncryptionMode = @import("encryption_mode.zig").EncryptionMode;
const LogSubscription = @import("log_subscription.zig").LogSubscription;
const Output = @import("output.zig").Output;
const RecipeReference = @import("recipe_reference.zig").RecipeReference;

pub const CreateRecipeJobInput = struct {
    /// Represents a list of JDBC database output objects which defines the output
    /// destination for
    /// a DataBrew recipe job to write to.
    database_outputs: ?[]const DatabaseOutput = null,

    /// One or more artifacts that represent the Glue Data Catalog output from
    /// running the job.
    data_catalog_outputs: ?[]const DataCatalogOutput = null,

    /// The name of the dataset that this job processes.
    dataset_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an encryption key that is used to protect
    /// the
    /// job.
    encryption_key_arn: ?[]const u8 = null,

    /// The encryption mode for the job, which can be one of the following:
    ///
    /// * `SSE-KMS` - Server-side encryption with keys managed by KMS.
    ///
    /// * `SSE-S3` - Server-side encryption with keys managed by Amazon S3.
    encryption_mode: ?EncryptionMode = null,

    /// Enables or disables Amazon CloudWatch logging for the job. If logging is
    /// enabled,
    /// CloudWatch writes one log stream for each job run.
    log_subscription: ?LogSubscription = null,

    /// The maximum number of nodes that DataBrew can consume when the job processes
    /// data.
    max_capacity: ?i32 = null,

    /// The maximum number of times to retry the job after a job run fails.
    max_retries: ?i32 = null,

    /// A unique name for the job. Valid characters are alphanumeric (A-Z, a-z,
    /// 0-9), hyphen
    /// (-), period (.), and space.
    name: []const u8,

    /// One or more artifacts that represent the output from running the job.
    outputs: ?[]const Output = null,

    /// Either the name of an existing project, or a combination of a recipe and a
    /// dataset to
    /// associate with the recipe.
    project_name: ?[]const u8 = null,

    recipe_reference: ?RecipeReference = null,

    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role to
    /// be assumed when DataBrew runs the job.
    role_arn: []const u8,

    /// Metadata tags to apply to this job.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The job's timeout in minutes. A job that attempts to run longer than this
    /// timeout
    /// period ends with a status of `TIMEOUT`.
    timeout: ?i32 = null,

    pub const json_field_names = .{
        .database_outputs = "DatabaseOutputs",
        .data_catalog_outputs = "DataCatalogOutputs",
        .dataset_name = "DatasetName",
        .encryption_key_arn = "EncryptionKeyArn",
        .encryption_mode = "EncryptionMode",
        .log_subscription = "LogSubscription",
        .max_capacity = "MaxCapacity",
        .max_retries = "MaxRetries",
        .name = "Name",
        .outputs = "Outputs",
        .project_name = "ProjectName",
        .recipe_reference = "RecipeReference",
        .role_arn = "RoleArn",
        .tags = "Tags",
        .timeout = "Timeout",
    };
};

pub const CreateRecipeJobOutput = struct {
    /// The name of the job that you created.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRecipeJobInput, options: CallOptions) !CreateRecipeJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "databrew", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRecipeJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databrew", "DataBrew", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/recipeJobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.database_outputs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DatabaseOutputs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.data_catalog_outputs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DataCatalogOutputs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dataset_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DatasetName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.encryption_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EncryptionKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.encryption_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EncryptionMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.log_subscription) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LogSubscription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_capacity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxCapacity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_retries) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxRetries\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.outputs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Outputs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.project_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ProjectName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.recipe_reference) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RecipeReference\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RoleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.timeout) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Timeout\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRecipeJobOutput {
    const result: CreateRecipeJobOutput = try aws.json.parseJsonObject(
        CreateRecipeJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
