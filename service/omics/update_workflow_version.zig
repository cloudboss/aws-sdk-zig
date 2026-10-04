const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StorageType = @import("storage_type.zig").StorageType;

pub const UpdateWorkflowVersionInput = struct {
    /// Description of the workflow version.
    description: ?[]const u8 = null,

    /// The markdown content for the workflow version's README file. This provides
    /// documentation and usage information for users of this specific workflow
    /// version.
    readme_markdown: ?[]const u8 = null,

    /// The default static storage capacity (in gibibytes) for runs that use this
    /// workflow version. The `storageCapacity` can be overwritten at run time. The
    /// storage capacity is not required for runs with a `DYNAMIC` storage type.
    storage_capacity: ?i32 = null,

    /// The default storage type for runs that use this workflow version. The
    /// `storageType` can be overridden at run time. `DYNAMIC` storage dynamically
    /// scales the storage up or down, based on file system utilization. STATIC
    /// storage allocates a fixed amount of storage. For more information about
    /// dynamic and static storage types, see [Run storage
    /// types](https://docs.aws.amazon.com/omics/latest/dev/workflows-run-types.html) in the *in the Amazon Web Services HealthOmics User Guide* .
    storage_type: ?StorageType = null,

    /// The name of the workflow version.
    version_name: []const u8,

    /// The workflow's ID. The `workflowId` is not the UUID.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .readme_markdown = "readmeMarkdown",
        .storage_capacity = "storageCapacity",
        .storage_type = "storageType",
        .version_name = "versionName",
        .workflow_id = "workflowId",
    };
};

pub const UpdateWorkflowVersionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkflowVersionInput, options: CallOptions) !UpdateWorkflowVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "omics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkflowVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workflow/");
    try path_buf.appendSlice(allocator, input.workflow_id);
    try path_buf.appendSlice(allocator, "/version/");
    try path_buf.appendSlice(allocator, input.version_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.readme_markdown) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"readmeMarkdown\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.storage_capacity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"storageCapacity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.storage_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"storageType\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkflowVersionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateWorkflowVersionOutput = .{};

    return result;
}
