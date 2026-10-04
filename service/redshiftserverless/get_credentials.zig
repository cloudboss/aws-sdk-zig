const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetCredentialsInput = struct {
    /// The custom domain name associated with the workgroup. The custom domain name
    /// or the workgroup name must be included in the request.
    custom_domain_name: ?[]const u8 = null,

    /// The name of the database to get temporary authorization to log on to.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 64 alphanumeric characters or hyphens.
    /// * Must contain only uppercase or lowercase letters, numbers, underscore,
    ///   plus sign, period (dot), at symbol (@), or hyphen.
    /// * The first character must be a letter.
    /// * Must not contain a colon ( : ) or slash ( / ).
    /// * Cannot be a reserved word. A list of reserved words can be found in
    ///   [Reserved Words
    ///   ](https://docs.aws.amazon.com/redshift/latest/dg/r_pg_keywords.html) in
    ///   the Amazon Redshift Database Developer Guide
    db_name: ?[]const u8 = null,

    /// The number of seconds until the returned temporary password expires. The
    /// minimum is 900 seconds, and the maximum is 3600 seconds.
    duration_seconds: ?i32 = null,

    /// The name of the workgroup associated with the database.
    workgroup_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_domain_name = "customDomainName",
        .db_name = "dbName",
        .duration_seconds = "durationSeconds",
        .workgroup_name = "workgroupName",
    };
};

pub const GetCredentialsOutput = struct {
    /// A temporary password that authorizes the user name returned by `DbUser` to
    /// log on to the database `DbName`.
    db_password: ?[]const u8 = null,

    /// A database user name that is authorized to log on to the database `DbName`
    /// using the password `DbPassword`. If the specified `DbUser` exists in the
    /// database, the new user name has the same database privileges as the the user
    /// named in `DbUser`. By default, the user is added to PUBLIC.
    db_user: ?[]const u8 = null,

    /// The date and time the password in `DbPassword` expires.
    expiration: ?i64 = null,

    /// The date and time of when the `DbUser` and `DbPassword` authorization
    /// refreshes.
    next_refresh_time: ?i64 = null,

    pub const json_field_names = .{
        .db_password = "dbPassword",
        .db_user = "dbUser",
        .expiration = "expiration",
        .next_refresh_time = "nextRefreshTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCredentialsInput, options: CallOptions) !GetCredentialsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCredentialsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.GetCredentials");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCredentialsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCredentialsOutput, body, allocator);
}
