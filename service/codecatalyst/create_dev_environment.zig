const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdeConfiguration = @import("ide_configuration.zig").IdeConfiguration;
const InstanceType = @import("instance_type.zig").InstanceType;
const PersistentStorageConfiguration = @import("persistent_storage_configuration.zig").PersistentStorageConfiguration;
const RepositoryInput = @import("repository_input.zig").RepositoryInput;

pub const CreateDevEnvironmentInput = struct {
    /// The user-defined alias for a Dev Environment.
    alias: ?[]const u8 = null,

    /// A user-specified idempotency token. Idempotency ensures that an API request
    /// completes only once.
    /// With an idempotent request, if the original request completes successfully,
    /// the subsequent retries return the result from the original successful
    /// request and have no additional effect.
    client_token: ?[]const u8 = null,

    /// Information about the integrated development environment (IDE) configured
    /// for a
    /// Dev Environment.
    ///
    /// An IDE is required to create a Dev Environment. For Dev Environment
    /// creation, this field
    /// contains configuration information and must be provided.
    ides: ?[]const IdeConfiguration = null,

    /// The amount of time the Dev Environment will run without any activity
    /// detected before stopping, in minutes. Only whole integers are allowed. Dev
    /// Environments consume compute minutes when running.
    inactivity_timeout_minutes: ?i32 = null,

    /// The Amazon EC2 instace type to use for the Dev Environment.
    instance_type: InstanceType,

    /// Information about the amount of storage allocated to the Dev Environment.
    ///
    /// By default, a Dev Environment is configured to have 16GB of persistent
    /// storage when created from the Amazon CodeCatalyst console, but there is no
    /// default when programmatically
    /// creating a Dev Environment.
    /// Valid values for persistent storage are based on memory sizes in 16GB
    /// increments. Valid
    /// values are 16, 32, and 64.
    persistent_storage: PersistentStorageConfiguration,

    /// The name of the project in the space.
    project_name: []const u8,

    /// The source repository that contains the branch to clone into the Dev
    /// Environment.
    repositories: ?[]const RepositoryInput = null,

    /// The name of the space.
    space_name: []const u8,

    /// The name of the connection that will be used to connect to Amazon VPC, if
    /// any.
    vpc_connection_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias = "alias",
        .client_token = "clientToken",
        .ides = "ides",
        .inactivity_timeout_minutes = "inactivityTimeoutMinutes",
        .instance_type = "instanceType",
        .persistent_storage = "persistentStorage",
        .project_name = "projectName",
        .repositories = "repositories",
        .space_name = "spaceName",
        .vpc_connection_name = "vpcConnectionName",
    };
};

pub const CreateDevEnvironmentOutput = struct {
    /// The system-generated unique ID of the Dev Environment.
    id: []const u8,

    /// The name of the project in the space.
    project_name: []const u8,

    /// The name of the space.
    space_name: []const u8,

    /// The name of the connection used to connect to Amazon VPC used when the Dev
    /// Environment was created, if any.
    vpc_connection_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .project_name = "projectName",
        .space_name = "spaceName",
        .vpc_connection_name = "vpcConnectionName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDevEnvironmentInput, options: CallOptions) !CreateDevEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecatalyst", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDevEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecatalyst", "CodeCatalyst", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/spaces/");
    try path_buf.appendSlice(allocator, input.space_name);
    try path_buf.appendSlice(allocator, "/projects/");
    try path_buf.appendSlice(allocator, input.project_name);
    try path_buf.appendSlice(allocator, "/devEnvironments");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.alias) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"alias\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ides) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ides\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.inactivity_timeout_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inactivityTimeoutMinutes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"instanceType\":");
    try aws.json.writeValue(@TypeOf(input.instance_type), input.instance_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"persistentStorage\":");
    try aws.json.writeValue(@TypeOf(input.persistent_storage), input.persistent_storage, allocator, &body_buf);
    has_prev = true;
    if (input.repositories) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"repositories\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_connection_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vpcConnectionName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDevEnvironmentOutput {
    var result: CreateDevEnvironmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDevEnvironmentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
