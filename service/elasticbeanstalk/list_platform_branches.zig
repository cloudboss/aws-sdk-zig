const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchFilter = @import("search_filter.zig").SearchFilter;
const PlatformBranchSummary = @import("platform_branch_summary.zig").PlatformBranchSummary;
const serde = @import("serde.zig");

pub const ListPlatformBranchesInput = struct {
    /// Criteria for restricting the resulting list of platform branches. The filter
    /// is evaluated
    /// as a logical conjunction (AND) of the separate `SearchFilter` terms.
    ///
    /// The following list shows valid attribute values for each of the
    /// `SearchFilter`
    /// terms. Most operators take a single value. The `in` and `not_in`
    /// operators can take multiple values.
    ///
    /// * `Attribute = BranchName`:
    ///
    /// * `Operator`: `=` | `!=` | `begins_with`
    /// | `ends_with` | `contains` | `in` |
    /// `not_in`
    ///
    /// * `Attribute = LifecycleState`:
    ///
    /// * `Operator`: `=` | `!=` | `in` |
    /// `not_in`
    ///
    /// * `Values`: `beta` | `supported` |
    /// `deprecated` | `retired`
    ///
    /// * `Attribute = PlatformName`:
    ///
    /// * `Operator`: `=` | `!=` | `begins_with`
    /// | `ends_with` | `contains` | `in` |
    /// `not_in`
    ///
    /// * `Attribute = TierType`:
    ///
    /// * `Operator`: `=` | `!=`
    ///
    /// * `Values`: `WebServer/Standard` | `Worker/SQS/HTTP`
    ///
    /// Array size: limited to 10 `SearchFilter` objects.
    ///
    /// Within each `SearchFilter` item, the `Values` array is limited to 10
    /// items.
    filters: ?[]const SearchFilter = null,

    /// The maximum number of platform branch values returned in one call.
    max_records: ?i32 = null,

    /// For a paginated request. Specify a token from a previous response page to
    /// retrieve the
    /// next response page. All other parameter values must be identical to the ones
    /// specified in the
    /// initial request.
    ///
    /// If no `NextToken` is specified, the first page is retrieved.
    next_token: ?[]const u8 = null,
};

pub const ListPlatformBranchesOutput = struct {
    /// In a paginated request, if this value isn't `null`, it's the token that you
    /// can
    /// pass in a subsequent request to get the next response page.
    next_token: ?[]const u8 = null,

    /// Summary information about the platform branches.
    platform_branch_summary_list: ?[]const PlatformBranchSummary = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPlatformBranchesInput, options: CallOptions) !ListPlatformBranchesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticbeanstalk", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPlatformBranchesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListPlatformBranches&Version=2010-12-01");
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.attribute) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.member.{d}.Attribute=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.operator) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.member.{d}.Operator=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.member.{d}.Values.member.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPlatformBranchesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListPlatformBranchesResult")) break;
            },
            else => {},
        }
    }

    var result: ListPlatformBranchesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformBranchSummaryList")) {
                    result.platform_branch_summary_list = try serde.deserializePlatformBranchSummaryList(allocator, &reader, "member");
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
