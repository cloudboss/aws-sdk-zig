const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceQuery = @import("resource_query.zig").ResourceQuery;

pub const StartTagSyncTaskInput = struct {
    /// The Amazon resource name (ARN) or name of the application group for which
    /// you want to create a tag-sync task.
    group: []const u8,

    /// The query you can use to create the tag-sync task. With this method, all
    /// resources matching the query
    /// are added to the specified application group. A
    /// `ResourceQuery` specifies both a query `Type` and a
    /// `Query` string as JSON string objects. For more information on defining a
    /// resource query for a
    /// tag-sync task, see the tag-based query type in [
    /// Types of resource group
    /// queries](https://docs.aws.amazon.com/ARG/latest/userguide/gettingstarted-query.html#getting_started-query_types) in *Resource Groups User Guide*.
    ///
    /// When using the `ResourceQuery` parameter, you cannot use the `TagKey` and
    /// `TagValue` parameters.
    ///
    /// When you combine all of the elements together into a single string, any
    /// double quotes
    /// that are embedded inside another double quote pair must be escaped by
    /// preceding the
    /// embedded double quote with a backslash character (\). For example, a
    /// complete
    /// `ResourceQuery` parameter must be formatted like the following CLI
    /// parameter example:
    ///
    /// `--resource-query
    /// '{"Type":"TAG_FILTERS_1_0","Query":"{\"ResourceTypeFilters\":[\"AWS::AllSupported\"],\"TagFilters\":[{\"Key\":\"Stage\",\"Values\":[\"Test\"]}]}"}'`
    ///
    /// In the preceding example, all of the double quote characters in the value
    /// part of the
    /// `Query` element must be escaped because the value itself is surrounded by
    /// double quotes. For more information, see [Quoting
    /// strings](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters-quoting-strings.html) in the *Command Line Interface User Guide*.
    ///
    /// For the complete list of resource types that you can use in the array value
    /// for
    /// `ResourceTypeFilters`, see [Resources
    /// you can use with Resource Groups and Tag
    /// Editor](https://docs.aws.amazon.com/ARG/latest/userguide/supported-resources.html) in the
    /// *Resource Groups User Guide*. For example:
    ///
    /// `"ResourceTypeFilters":["AWS::S3::Bucket", "AWS::EC2::Instance"]`
    resource_query: ?ResourceQuery = null,

    /// The Amazon resource name (ARN) of the role assumed by the service to tag and
    /// untag resources on your behalf.
    role_arn: []const u8,

    /// The tag key. Resources tagged with this tag key-value pair will be added to
    /// the application. If a resource with this tag is later untagged, the tag-sync
    /// task removes
    /// the resource from the application.
    ///
    /// When using the `TagKey` parameter, you must also specify the `TagValue`
    /// parameter. If you specify a tag key-value pair,
    /// you can't use the `ResourceQuery` parameter.
    tag_key: ?[]const u8 = null,

    /// The tag value. Resources tagged with this tag key-value pair will be added
    /// to
    /// the application. If a resource with this tag is later untagged, the tag-sync
    /// task removes
    /// the resource from the application.
    ///
    /// When using the `TagValue` parameter, you must also specify the `TagKey`
    /// parameter. If you specify a tag key-value pair,
    /// you can't use the `ResourceQuery` parameter.
    tag_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .group = "Group",
        .resource_query = "ResourceQuery",
        .role_arn = "RoleArn",
        .tag_key = "TagKey",
        .tag_value = "TagValue",
    };
};

pub const StartTagSyncTaskOutput = struct {
    /// The Amazon resource name (ARN) of the application group for which you want
    /// to add or remove resources.
    group_arn: ?[]const u8 = null,

    /// The name of the application group to onboard and sync resources.
    group_name: ?[]const u8 = null,

    resource_query: ?ResourceQuery = null,

    /// The Amazon resource name (ARN) of the role assumed by the service to tag and
    /// untag resources on your behalf.
    role_arn: ?[]const u8 = null,

    /// The tag key of the tag-sync task.
    tag_key: ?[]const u8 = null,

    /// The tag value of the tag-sync task.
    tag_value: ?[]const u8 = null,

    /// The Amazon resource name (ARN) of the new tag-sync task.
    task_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_arn = "GroupArn",
        .group_name = "GroupName",
        .resource_query = "ResourceQuery",
        .role_arn = "RoleArn",
        .tag_key = "TagKey",
        .tag_value = "TagValue",
        .task_arn = "TaskArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTagSyncTaskInput, options: CallOptions) !StartTagSyncTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resource-groups", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartTagSyncTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-groups", "Resource Groups", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/start-tag-sync-task";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Group\":");
    try aws.json.writeValue(@TypeOf(input.group), input.group, allocator, &body_buf);
    has_prev = true;
    if (input.resource_query) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceQuery\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RoleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tag_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TagKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tag_value) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TagValue\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartTagSyncTaskOutput {
    const result: StartTagSyncTaskOutput = try aws.json.parseJsonObject(
        StartTagSyncTaskOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
