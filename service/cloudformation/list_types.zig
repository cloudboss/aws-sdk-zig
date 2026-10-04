const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeprecatedStatus = @import("deprecated_status.zig").DeprecatedStatus;
const TypeFilters = @import("type_filters.zig").TypeFilters;
const ProvisioningType = @import("provisioning_type.zig").ProvisioningType;
const RegistryType = @import("registry_type.zig").RegistryType;
const Visibility = @import("visibility.zig").Visibility;
const TypeSummary = @import("type_summary.zig").TypeSummary;
const serde = @import("serde.zig");

pub const ListTypesInput = struct {
    /// The deprecation status of the extension that you want to get summary
    /// information
    /// about.
    ///
    /// Valid values include:
    ///
    /// * `LIVE`: The extension is registered for use in CloudFormation
    /// operations.
    ///
    /// * `DEPRECATED`: The extension has been deregistered and can no longer be
    ///   used
    /// in CloudFormation operations.
    deprecated_status: ?DeprecatedStatus = null,

    /// Filter criteria to use in determining which extensions to return.
    ///
    /// Filters must be compatible with `Visibility` to return valid results. For
    /// example, specifying `AWS_TYPES` for `Category` and `PRIVATE`
    /// for `Visibility` returns an empty list of types, but specifying `PUBLIC`
    /// for `Visibility` returns the desired list.
    filters: ?TypeFilters = null,

    /// The maximum number of results to be returned with a single call. If the
    /// number of
    /// available results exceeds this maximum, the response includes a `NextToken`
    /// value
    /// that you can assign to the `NextToken` request parameter to get the next set
    /// of
    /// results.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// For resource types, the provisioning behavior of the resource type.
    /// CloudFormation determines
    /// the provisioning type during registration, based on the types of handlers in
    /// the schema
    /// handler package submitted.
    ///
    /// Valid values include:
    ///
    /// * `FULLY_MUTABLE`: The resource type includes an update handler to process
    /// updates to the type during stack update operations.
    ///
    /// * `IMMUTABLE`: The resource type doesn't include an update handler, so the
    /// type can't be updated and must instead be replaced during stack update
    /// operations.
    ///
    /// * `NON_PROVISIONABLE`: The resource type doesn't include create, read, and
    /// delete handlers, and therefore can't actually be provisioned.
    ///
    /// The default is `FULLY_MUTABLE`.
    provisioning_type: ?ProvisioningType = null,

    /// The type of extension.
    @"type": ?RegistryType = null,

    /// The scope at which the extensions are visible and usable in CloudFormation
    /// operations.
    ///
    /// Valid values include:
    ///
    /// * `PRIVATE`: Extensions that are visible and usable within this account and
    /// Region. This includes:
    ///
    /// * Private extensions you have registered in this account and Region.
    ///
    /// * Public extensions that you have activated in this account and Region.
    ///
    /// * `PUBLIC`: Extensions that are publicly visible and available to be
    /// activated within any Amazon Web Services account. This includes extensions
    /// from Amazon Web Services and third-party
    /// publishers.
    ///
    /// The default is `PRIVATE`.
    visibility: ?Visibility = null,
};

pub const ListTypesOutput = struct {
    /// If the request doesn't return all the remaining results, `NextToken` is set
    /// to
    /// a token. To retrieve the next set of results, call this action again and
    /// assign that token to
    /// the request object's `NextToken` parameter. If the request returns all
    /// results,
    /// `NextToken` is set to `null`.
    next_token: ?[]const u8 = null,

    /// A list of `TypeSummary` structures that contain information about the
    /// specified
    /// extensions.
    type_summaries: ?[]const TypeSummary = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTypesInput, options: CallOptions) !ListTypesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTypesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListTypes&Version=2010-05-15");
    if (input.deprecated_status) |v| {
        try body_buf.appendSlice(allocator, "&DeprecatedStatus=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.filters) |v| {
        if (v.category) |sv| {
            try body_buf.appendSlice(allocator, "&Filters.Category=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.publisher_id) |sv| {
            try body_buf.appendSlice(allocator, "&Filters.PublisherId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.type_name_prefix) |sv| {
            try body_buf.appendSlice(allocator, "&Filters.TypeNamePrefix=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.provisioning_type) |v| {
        try body_buf.appendSlice(allocator, "&ProvisioningType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.@"type") |v| {
        try body_buf.appendSlice(allocator, "&Type=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.visibility) |v| {
        try body_buf.appendSlice(allocator, "&Visibility=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTypesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListTypesResult")) break;
            },
            else => {},
        }
    }

    var result: ListTypesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeSummaries")) {
                    result.type_summaries = try serde.deserializeTypeSummaries(allocator, &reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
