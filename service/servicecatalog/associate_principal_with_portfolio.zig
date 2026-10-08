const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PrincipalType = @import("principal_type.zig").PrincipalType;

pub const AssociatePrincipalWithPortfolioInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The portfolio identifier.
    portfolio_id: []const u8,

    /// The ARN of the principal (user, role, or group). If the `PrincipalType` is
    /// `IAM`, the supported value is a
    /// fully defined
    /// [IAM Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns).
    /// If the `PrincipalType` is `IAM_PATTERN`,
    /// the supported value is an `IAM` ARN *without an AccountID* in the following
    /// format:
    ///
    /// *arn:partition:iam:::resource-type/resource-id*
    ///
    /// The ARN resource-id can be either:
    ///
    /// * A fully formed resource-id. For example,
    ///   *arn:aws:iam:::role/resource-name* or
    /// *arn:aws:iam:::role/resource-path/resource-name*
    ///
    /// * A wildcard ARN. The wildcard ARN accepts `IAM_PATTERN` values with a
    /// "*" or "?" in the resource-id segment of the ARN. For example
    /// *arn:partition:service:::resource-type/resource-path/resource-name*.
    /// The new symbols are exclusive to the **resource-path** and **resource-name**
    /// and cannot replace the **resource-type** or other
    /// ARN values.
    ///
    /// The ARN path and principal name allow unlimited wildcard characters.
    ///
    /// Examples of an **acceptable** wildcard ARN:
    ///
    /// * arn:aws:iam:::role/ResourceName_*
    ///
    /// * arn:aws:iam:::role/*/ResourceName_?
    ///
    /// Examples of an **unacceptable** wildcard ARN:
    ///
    /// * arn:aws:iam:::*/ResourceName
    ///
    /// You can associate multiple `IAM_PATTERN`s even if the account has no
    /// principal
    /// with that name.
    ///
    /// The "?" wildcard character matches zero or one of any character. This is
    /// similar to ".?" in regular
    /// regex context. The "*" wildcard character matches any number of any
    /// characters.
    /// This is similar to ".*" in regular regex context.
    ///
    /// In the IAM Principal ARN format
    /// (*arn:partition:iam:::resource-type/resource-path/resource-name*),
    /// valid resource-type values include **user/**, **group/**,
    /// or **role/**. The "?" and "*" characters
    /// are allowed only after the resource-type in the resource-id segment.
    /// You can use special characters anywhere within the resource-id.
    ///
    /// The "*" character also matches the "/" character, allowing paths to be
    /// formed *within* the
    /// resource-id. For example, *arn:aws:iam:::role/*****/ResourceName_?*
    /// matches both *arn:aws:iam:::role/pathA/pathB/ResourceName_1*
    /// and
    /// *arn:aws:iam:::role/pathA/ResourceName_1*.
    principal_arn: []const u8,

    /// The principal type. The supported value is `IAM` if you use a fully defined
    /// Amazon Resource Name
    /// (ARN), or `IAM_PATTERN` if you use an ARN with no `accountID`,
    /// with or without wildcard characters.
    principal_type: PrincipalType,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .portfolio_id = "PortfolioId",
        .principal_arn = "PrincipalARN",
        .principal_type = "PrincipalType",
    };
};

pub const AssociatePrincipalWithPortfolioOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociatePrincipalWithPortfolioInput, options: CallOptions) !AssociatePrincipalWithPortfolioOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicecatalog", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociatePrincipalWithPortfolioInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog", "Service Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.AssociatePrincipalWithPortfolio");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociatePrincipalWithPortfolioOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
