const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageVersionArtifact = @import("package_version_artifact.zig").PackageVersionArtifact;
const Sbom = @import("sbom.zig").Sbom;
const SbomValidationStatus = @import("sbom_validation_status.zig").SbomValidationStatus;
const PackageVersionStatus = @import("package_version_status.zig").PackageVersionStatus;

pub const GetPackageVersionInput = struct {
    /// The name of the associated package.
    package_name: []const u8,

    /// The name of the target package version.
    version_name: []const u8,

    pub const json_field_names = .{
        .package_name = "packageName",
        .version_name = "versionName",
    };
};

pub const GetPackageVersionOutput = struct {
    /// The various components that make up a software package version.
    artifact: ?PackageVersionArtifact = null,

    /// Metadata that were added to the package version that can be used to define a
    /// package version’s configuration.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The date when the package version was created.
    creation_date: ?i64 = null,

    /// The package version description.
    description: ?[]const u8 = null,

    /// Error reason for a package version failure during creation or update.
    error_reason: ?[]const u8 = null,

    /// The date when the package version was last updated.
    last_modified_date: ?i64 = null,

    /// The name of the software package.
    package_name: ?[]const u8 = null,

    /// The ARN for the package version.
    package_version_arn: ?[]const u8 = null,

    /// The inline job document associated with a software package version used for
    /// a quick job
    /// deployment.
    recipe: ?[]const u8 = null,

    /// The software bill of materials for a software package version.
    sbom: ?Sbom = null,

    /// The status of the validation for a new software bill of materials added to a
    /// software
    /// package version.
    sbom_validation_status: ?SbomValidationStatus = null,

    /// The status associated to the package version. For more information, see
    /// [Package version
    /// lifecycle](https://docs.aws.amazon.com/iot/latest/developerguide/preparing-to-use-software-package-catalog.html#package-version-lifecycle).
    status: ?PackageVersionStatus = null,

    /// The name of the package version.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifact = "artifact",
        .attributes = "attributes",
        .creation_date = "creationDate",
        .description = "description",
        .error_reason = "errorReason",
        .last_modified_date = "lastModifiedDate",
        .package_name = "packageName",
        .package_version_arn = "packageVersionArn",
        .recipe = "recipe",
        .sbom = "sbom",
        .sbom_validation_status = "sbomValidationStatus",
        .status = "status",
        .version_name = "versionName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPackageVersionInput, options: CallOptions) !GetPackageVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPackageVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/packages/");
    try path_buf.appendSlice(allocator, input.package_name);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.version_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPackageVersionOutput {
    const result: GetPackageVersionOutput = try aws.json.parseJsonObject(
        GetPackageVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
