const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceShareAssociationStatus = @import("resource_share_association_status.zig").ResourceShareAssociationStatus;
const PermissionFeatureSet = @import("permission_feature_set.zig").PermissionFeatureSet;
const AssociatedPermission = @import("associated_permission.zig").AssociatedPermission;

pub const ListPermissionAssociationsInput = struct {
    /// Specifies that you want to list only those associations with resource shares
    /// that match this
    /// status.
    association_status: ?ResourceShareAssociationStatus = null,

    /// When `true`, specifies that you want to list only those associations with
    /// resource shares that use the default version of the specified managed
    /// permission.
    ///
    /// When `false` (the default value), lists associations with resource shares
    /// that use
    /// any version of the specified managed permission.
    default_version: ?bool = null,

    /// Specifies that you want to list only those associations with resource shares
    /// that have a
    /// `featureSet` with this value.
    feature_set: ?PermissionFeatureSet = null,

    /// Specifies the total number of results that you want included on each page
    /// of the response. If you do not include this parameter, it defaults to a
    /// value that is
    /// specific to the operation. If additional items exist beyond the number you
    /// specify, the
    /// `NextToken` response element is returned with a value (not null).
    /// Include the specified value as the `NextToken` request parameter in the next
    /// call to the operation to get the next part of the results. Note that the
    /// service might
    /// return fewer results than the maximum even when there are more results
    /// available. You
    /// should check `NextToken` after every operation to ensure that you receive
    /// all
    /// of the results.
    max_results: ?i32 = null,

    /// Specifies that you want to receive the next page of results. Valid
    /// only if you received a `NextToken` response in the previous request. If you
    /// did, it indicates that more output is available. Set this parameter to the
    /// value
    /// provided by the previous call's `NextToken` response to request the
    /// next page of results.
    next_token: ?[]const u8 = null,

    /// Specifies the [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the managed permission.
    permission_arn: ?[]const u8 = null,

    /// Specifies that you want to list only those associations with resource shares
    /// that use this
    /// version of the managed permission. If you don't provide a value for this
    /// parameter, then the operation
    /// returns information about associations with resource shares that use any
    /// version of the
    /// managed permission.
    permission_version: ?i32 = null,

    /// Specifies that you want to list only those associations with resource shares
    /// that include at
    /// least one resource of this resource type.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_status = "associationStatus",
        .default_version = "defaultVersion",
        .feature_set = "featureSet",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .permission_arn = "permissionArn",
        .permission_version = "permissionVersion",
        .resource_type = "resourceType",
    };
};

pub const ListPermissionAssociationsOutput = struct {
    /// If present, this value indicates that more output is available than
    /// is included in the current response. Use this value in the `NextToken`
    /// request parameter in a subsequent call to the operation to get the next part
    /// of the
    /// output. You should repeat this until the `NextToken` response element comes
    /// back as `null`. This indicates that this is the last page of results.
    next_token: ?[]const u8 = null,

    /// A structure with information about this customer managed permission.
    permissions: ?[]const AssociatedPermission = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .permissions = "permissions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPermissionAssociationsInput, options: CallOptions) !ListPermissionAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ram", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPermissionAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ram", "RAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/listpermissionassociations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.association_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"associationStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.default_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"defaultVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.feature_set) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"featureSet\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.permission_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"permissionArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.permission_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"permissionVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceType\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPermissionAssociationsOutput {
    var result: ListPermissionAssociationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListPermissionAssociationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
