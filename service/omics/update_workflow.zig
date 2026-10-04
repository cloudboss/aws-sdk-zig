const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StorageType = @import("storage_type.zig").StorageType;

pub const UpdateWorkflowInput = struct {
    /// A description for the workflow.
    description: ?[]const u8 = null,

    /// The workflow's ID.
    id: []const u8,

    /// A name for the workflow.
    name: ?[]const u8 = null,

    /// The markdown content for the workflow's README file. This provides
    /// documentation and usage information for users of the workflow.
    readme_markdown: ?[]const u8 = null,

    /// The default static storage capacity (in gibibytes) for runs that use this
    /// workflow or workflow version.
    storage_capacity: ?i32 = null,

    /// The default storage type for runs that use this workflow. STATIC storage
    /// allocates a fixed amount of storage. DYNAMIC storage dynamically scales the
    /// storage up or down, based on file system utilization. For more information
    /// about static and dynamic storage, see [Running
    /// workflows](https://docs.aws.amazon.com/omics/latest/dev/Using-workflows.html) in the *Amazon Web Services HealthOmics User Guide*.
    storage_type: ?StorageType = null,

    pub const json_field_names = .{
        .description = "description",
        .id = "id",
        .name = "name",
        .readme_markdown = "readmeMarkdown",
        .storage_capacity = "storageCapacity",
        .storage_type = "storageType",
    };
};

pub const UpdateWorkflowOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkflowInput, options: CallOptions) !UpdateWorkflowOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workflow/");
    try path_buf.appendSlice(allocator, input.id);
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
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkflowOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateWorkflowOutput = .{};

    return result;
}
