const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PatchOrchestratorFilter = @import("patch_orchestrator_filter.zig").PatchOrchestratorFilter;
const Patch = @import("patch.zig").Patch;

pub const DescribeAvailablePatchesInput = struct {
    /// Each element in the array is a structure containing a key-value pair.
    ///
    /// **Windows Server**
    ///
    /// Supported keys for Windows Server managed node patches include the
    /// following:
    ///
    /// * **
    /// `PATCH_SET`
    /// **
    ///
    /// Sample values: `OS` | `APPLICATION`
    ///
    /// * **
    /// `PRODUCT`
    /// **
    ///
    /// Sample values: `WindowsServer2012` | `Office 2010` |
    /// `MicrosoftDefenderAntivirus`
    ///
    /// * **
    /// `PRODUCT_FAMILY`
    /// **
    ///
    /// Sample values: `Windows` | `Office`
    ///
    /// * **
    /// `MSRC_SEVERITY`
    /// **
    ///
    /// Sample values: `ServicePacks` | `Important` | `Moderate`
    ///
    /// * **
    /// `CLASSIFICATION`
    /// **
    ///
    /// Sample values: `ServicePacks` | `SecurityUpdates` |
    /// `DefinitionUpdates`
    ///
    /// * **
    /// `PATCH_ID`
    /// **
    ///
    /// Sample values: `KB123456` | `KB4516046`
    ///
    /// **Linux**
    ///
    /// When specifying filters for Linux patches, you must specify a key-pair for
    /// `PRODUCT`. For example, using the Command Line Interface (CLI), the
    /// following command fails:
    ///
    /// `aws ssm describe-available-patches --filters
    /// Key=CVE_ID,Values=CVE-2018-3615`
    ///
    /// However, the following command succeeds:
    ///
    /// `aws ssm describe-available-patches --filters
    /// Key=PRODUCT,Values=AmazonLinux2018.03
    /// Key=CVE_ID,Values=CVE-2018-3615`
    ///
    /// Supported keys for Linux managed node patches include the following:
    ///
    /// * **
    /// `PRODUCT`
    /// **
    ///
    /// Sample values: `AmazonLinux2018.03` | `AmazonLinux2.0`
    ///
    /// * **
    /// `NAME`
    /// **
    ///
    /// Sample values: `kernel-headers` | `samba-python` | `php`
    ///
    /// * **
    /// `SEVERITY`
    /// **
    ///
    /// Sample values: `Critical` | `Important` | `Medium` |
    /// `Low`
    ///
    /// * **
    /// `EPOCH`
    /// **
    ///
    /// Sample values: `0` | `1`
    ///
    /// * **
    /// `VERSION`
    /// **
    ///
    /// Sample values: `78.6.1` | `4.10.16`
    ///
    /// * **
    /// `RELEASE`
    /// **
    ///
    /// Sample values: `9.56.amzn1` | `1.amzn2`
    ///
    /// * **
    /// `ARCH`
    /// **
    ///
    /// Sample values: `i686` | `x86_64`
    ///
    /// * **
    /// `REPOSITORY`
    /// **
    ///
    /// Sample values: `Core` | `Updates`
    ///
    /// * **
    /// `ADVISORY_ID`
    /// **
    ///
    /// Sample values: `ALAS-2018-1058` | `ALAS2-2021-1594`
    ///
    /// * **
    /// `CVE_ID`
    /// **
    ///
    /// Sample values: `CVE-2018-3615` | `CVE-2020-1472`
    ///
    /// * **
    /// `BUGZILLA_ID`
    /// **
    ///
    /// Sample values: `1463241`
    filters: ?[]const PatchOrchestratorFilter = null,

    /// The maximum number of patches to return (per page).
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeAvailablePatchesOutput = struct {
    /// The token to use when requesting the next set of items. If there are no
    /// additional items to
    /// return, the string is empty.
    next_token: ?[]const u8 = null,

    /// An array of patches. Each entry in the array is a patch structure.
    patches: ?[]const Patch = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .patches = "Patches",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAvailablePatchesInput, options: CallOptions) !DescribeAvailablePatchesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAvailablePatchesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribeAvailablePatches");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAvailablePatchesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAvailablePatchesOutput, body, allocator);
}
