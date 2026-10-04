const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecipeStep = @import("recipe_step.zig").RecipeStep;

pub const DescribeRecipeInput = struct {
    /// The name of the recipe to be described.
    name: []const u8,

    /// The recipe version identifier. If this parameter isn't specified, then the
    /// latest
    /// published version is returned.
    recipe_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .recipe_version = "RecipeVersion",
    };
};

pub const DescribeRecipeOutput = struct {
    /// The date and time that the recipe was created.
    create_date: ?i64 = null,

    /// The identifier (user name) of the user who created the recipe.
    created_by: ?[]const u8 = null,

    /// The description of the recipe.
    description: ?[]const u8 = null,

    /// The identifier (user name) of the user who last modified the recipe.
    last_modified_by: ?[]const u8 = null,

    /// The date and time that the recipe was last modified.
    last_modified_date: ?i64 = null,

    /// The name of the recipe.
    name: []const u8,

    /// The name of the project associated with this recipe.
    project_name: ?[]const u8 = null,

    /// The identifier (user name) of the user who last published the recipe.
    published_by: ?[]const u8 = null,

    /// The date and time when the recipe was last published.
    published_date: ?i64 = null,

    /// The recipe version identifier.
    recipe_version: ?[]const u8 = null,

    /// The ARN of the recipe.
    resource_arn: ?[]const u8 = null,

    /// One or more steps to be performed by the recipe. Each step consists of an
    /// action, and
    /// the conditions under which the action should succeed.
    steps: ?[]const RecipeStep = null,

    /// Metadata tags associated with this project.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .create_date = "CreateDate",
        .created_by = "CreatedBy",
        .description = "Description",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .project_name = "ProjectName",
        .published_by = "PublishedBy",
        .published_date = "PublishedDate",
        .recipe_version = "RecipeVersion",
        .resource_arn = "ResourceArn",
        .steps = "Steps",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRecipeInput, options: CallOptions) !DescribeRecipeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRecipeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databrew", "DataBrew", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/recipes/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.recipe_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "recipeVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRecipeOutput {
    const result: DescribeRecipeOutput = try aws.json.parseJsonObject(
        DescribeRecipeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
