const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KMSKeyDetails = @import("kms_key_details.zig").KMSKeyDetails;
const Repository = @import("repository.zig").Repository;
const RepositoryAssociation = @import("repository_association.zig").RepositoryAssociation;

pub const AssociateRepositoryInput = struct {
    /// Amazon CodeGuru Reviewer uses this value to prevent the accidental creation
    /// of duplicate repository
    /// associations if there are failures and retries.
    client_request_token: ?[]const u8 = null,

    /// A `KMSKeyDetails` object that contains:
    ///
    /// * The encryption option for this repository association. It is either owned
    ///   by Amazon Web Services
    /// Key Management Service (KMS) (`AWS_OWNED_CMK`) or customer managed
    /// (`CUSTOMER_MANAGED_CMK`).
    ///
    /// * The ID of the Amazon Web Services KMS key that is associated with this
    ///   repository
    /// association.
    kms_key_details: ?KMSKeyDetails = null,

    /// The repository to associate.
    repository: Repository,

    /// An array of key-value pairs used to tag an associated repository. A tag is a
    /// custom attribute label with two parts:
    ///
    /// * A *tag key* (for example, `CostCenter`,
    /// `Environment`, `Project`, or `Secret`). Tag
    /// keys are case sensitive.
    ///
    /// * An optional field known as a *tag value* (for example,
    /// `111122223333`, `Production`, or a team name).
    /// Omitting the tag value is the same as using an empty string. Like tag keys,
    /// tag
    /// values are case sensitive.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .kms_key_details = "KMSKeyDetails",
        .repository = "Repository",
        .tags = "Tags",
    };
};

pub const AssociateRepositoryOutput = struct {
    /// Information about the repository association.
    repository_association: ?RepositoryAssociation = null,

    /// An array of key-value pairs used to tag an associated repository. A tag is a
    /// custom attribute label with two parts:
    ///
    /// * A *tag key* (for example, `CostCenter`,
    /// `Environment`, `Project`, or `Secret`). Tag
    /// keys are case sensitive.
    ///
    /// * An optional field known as a *tag value* (for example,
    /// `111122223333`, `Production`, or a team name).
    /// Omitting the tag value is the same as using an empty string. Like tag keys,
    /// tag
    /// values are case sensitive.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .repository_association = "RepositoryAssociation",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateRepositoryInput, options: CallOptions) !AssociateRepositoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeguru-reviewer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateRepositoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-reviewer", "CodeGuru Reviewer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/associations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_details) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KMSKeyDetails\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Repository\":");
    try aws.json.writeValue(@TypeOf(input.repository), input.repository, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateRepositoryOutput {
    const result: AssociateRepositoryOutput = try aws.json.parseJsonObject(
        AssociateRepositoryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
