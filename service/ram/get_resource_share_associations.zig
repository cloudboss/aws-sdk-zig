const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceShareAssociationStatus = @import("resource_share_association_status.zig").ResourceShareAssociationStatus;
const ResourceShareAssociationType = @import("resource_share_association_type.zig").ResourceShareAssociationType;
const ResourceShareAssociation = @import("resource_share_association.zig").ResourceShareAssociation;

pub const GetResourceShareAssociationsInput = struct {
    /// Specifies that you want to retrieve only associations that have this status.
    association_status: ?ResourceShareAssociationStatus = null,

    /// Specifies whether you want to retrieve the associations that involve a
    /// specified
    /// resource or principal.
    ///
    /// * `PRINCIPAL` – list the principals whose associations you
    /// want to see.
    ///
    /// * `RESOURCE` – list the resources whose associations you want
    /// to see.
    association_type: ResourceShareAssociationType,

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

    /// Specifies the ID of the principal whose resource shares you want to
    /// retrieve. This can be an
    /// Amazon Web Services account ID, an organization ID, an organizational unit
    /// ID, or the [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of an
    /// individual IAM role or user.
    ///
    /// You cannot specify this parameter if the association type is
    /// `RESOURCE`.
    principal: ?[]const u8 = null,

    /// Specifies the [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of a resource whose resource shares you want to retrieve.
    ///
    /// You cannot specify this parameter if the association type is
    /// `PRINCIPAL`.
    resource_arn: ?[]const u8 = null,

    /// Specifies a list of [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the resource share whose associations you want to
    /// retrieve.
    resource_share_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .association_status = "associationStatus",
        .association_type = "associationType",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .principal = "principal",
        .resource_arn = "resourceArn",
        .resource_share_arns = "resourceShareArns",
    };
};

pub const GetResourceShareAssociationsOutput = struct {
    /// If present, this value indicates that more output is available than
    /// is included in the current response. Use this value in the `NextToken`
    /// request parameter in a subsequent call to the operation to get the next part
    /// of the
    /// output. You should repeat this until the `NextToken` response element comes
    /// back as `null`. This indicates that this is the last page of results.
    next_token: ?[]const u8 = null,

    /// An array of objects that contain the details about the associations.
    resource_share_associations: ?[]const ResourceShareAssociation = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .resource_share_associations = "resourceShareAssociations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceShareAssociationsInput, options: CallOptions) !GetResourceShareAssociationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceShareAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ram", "RAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/getresourceshareassociations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.association_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"associationStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"associationType\":");
    try aws.json.writeValue(@TypeOf(input.association_type), input.association_type, allocator, &body_buf);
    has_prev = true;
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
    if (input.principal) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"principal\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_share_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceShareArns\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceShareAssociationsOutput {
    var result: GetResourceShareAssociationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetResourceShareAssociationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
