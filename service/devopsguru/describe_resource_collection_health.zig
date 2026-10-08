const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceCollectionType = @import("resource_collection_type.zig").ResourceCollectionType;
const CloudFormationHealth = @import("cloud_formation_health.zig").CloudFormationHealth;
const ServiceHealth = @import("service_health.zig").ServiceHealth;
const TagHealth = @import("tag_health.zig").TagHealth;

pub const DescribeResourceCollectionHealthInput = struct {
    /// The pagination token to use to retrieve
    /// the next page of results for this operation. If this value is null, it
    /// retrieves the first page.
    next_token: ?[]const u8 = null,

    /// An Amazon Web Services resource collection type. This type specifies how
    /// analyzed Amazon Web Services resources
    /// are defined. The two types of Amazon Web Services resource collections
    /// supported are Amazon Web Services CloudFormation stacks and
    /// Amazon Web Services resources that contain the same Amazon Web Services tag.
    /// DevOps Guru can be configured to analyze
    /// the Amazon Web Services resources that are defined in the stacks or that are
    /// tagged using the same tag *key*. You can specify up to 500 Amazon Web
    /// Services CloudFormation stacks.
    resource_collection_type: ResourceCollectionType,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_collection_type = "ResourceCollectionType",
    };
};

pub const DescribeResourceCollectionHealthOutput = struct {
    /// The returned `CloudFormationHealthOverview` object that contains an
    /// `InsightHealthOverview` object with the requested system health
    /// information.
    cloud_formation: ?[]const CloudFormationHealth = null,

    /// The pagination token to use to retrieve
    /// the next page of results for this operation. If there are no more pages,
    /// this value is null.
    next_token: ?[]const u8 = null,

    /// An array of `ServiceHealth` objects that describes the health of the Amazon
    /// Web Services
    /// services associated with the resources in the collection.
    service: ?[]const ServiceHealth = null,

    /// The Amazon Web Services tags that are used by resources in the resource
    /// collection.
    ///
    /// Tags help you identify and organize your Amazon Web Services resources. Many
    /// Amazon Web Services services support
    /// tagging, so you can assign the same tag to resources from different services
    /// to indicate
    /// that the resources are related. For example, you can assign the same tag to
    /// an Amazon DynamoDB
    /// table resource that you assign to an Lambda function. For more information
    /// about
    /// using tags, see the [Tagging
    /// best
    /// practices](https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html) whitepaper.
    ///
    /// Each Amazon Web Services tag has two parts.
    ///
    /// * A tag *key* (for example, `CostCenter`,
    /// `Environment`, `Project`, or `Secret`). Tag
    /// *keys* are case-sensitive.
    ///
    /// * An optional field known as a tag *value* (for example,
    /// `111122223333`, `Production`, or a team
    /// name). Omitting the tag *value* is the same as using an empty
    /// string. Like tag *keys*, tag *values* are
    /// case-sensitive.
    ///
    /// Together these are known as *key*-*value* pairs.
    ///
    /// The string used for a *key* in a tag that you use to define your resource
    /// coverage must begin with the
    /// prefix `Devops-guru-`. The tag *key* might be
    /// `DevOps-Guru-deployment-application` or
    /// `devops-guru-rds-application`. When you create a *key*, the case of
    /// characters in the *key* can be whatever you choose. After you create a
    /// *key*, it is case-sensitive.
    /// For example, DevOps Guru works with a
    /// *key* named `devops-guru-rds` and a *key* named
    /// `DevOps-Guru-RDS`, and these act as two different *keys*. Possible
    /// *key*/*value* pairs in your
    /// application might be `Devops-Guru-production-application/RDS` or
    /// `Devops-Guru-production-application/containers`.
    tags: ?[]const TagHealth = null,

    pub const json_field_names = .{
        .cloud_formation = "CloudFormation",
        .next_token = "NextToken",
        .service = "Service",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeResourceCollectionHealthInput, options: CallOptions) !DescribeResourceCollectionHealthOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devops-guru", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeResourceCollectionHealthInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devops-guru", "DevOps Guru", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/health/resource-collection/");
    try path_buf.appendSlice(allocator, input.resource_collection_type.wireName());
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeResourceCollectionHealthOutput {
    const result: DescribeResourceCollectionHealthOutput = try aws.json.parseJsonObject(
        DescribeResourceCollectionHealthOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
