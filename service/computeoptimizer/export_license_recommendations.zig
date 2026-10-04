const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportableLicenseField = @import("exportable_license_field.zig").ExportableLicenseField;
const FileFormat = @import("file_format.zig").FileFormat;
const LicenseRecommendationFilter = @import("license_recommendation_filter.zig").LicenseRecommendationFilter;
const S3DestinationConfig = @import("s3_destination_config.zig").S3DestinationConfig;
const S3Destination = @import("s3_destination.zig").S3Destination;

pub const ExportLicenseRecommendationsInput = struct {
    /// The IDs of the Amazon Web Services accounts for which to export license
    /// recommendations.
    ///
    /// If your account is the management account of an organization, use this
    /// parameter to
    /// specify the member account for which you want to export recommendations.
    ///
    /// This parameter can't be specified together with the include member accounts
    /// parameter. The parameters are mutually exclusive.
    ///
    /// If this parameter is omitted, recommendations
    /// for member accounts aren't included in the export.
    ///
    /// You can specify multiple account IDs per request.
    account_ids: ?[]const []const u8 = null,

    /// The recommendations data to include in the export file. For more information
    /// about the
    /// fields that can be exported, see [Exported
    /// files](https://docs.aws.amazon.com/compute-optimizer/latest/ug/exporting-recommendations.html#exported-files) in the *Compute Optimizer User
    /// Guide*.
    fields_to_export: ?[]const ExportableLicenseField = null,

    /// The format of the export file.
    ///
    /// A CSV file is the only export format currently supported.
    file_format: ?FileFormat = null,

    /// An array of objects to specify a filter that exports a more specific set of
    /// license recommendations.
    filters: ?[]const LicenseRecommendationFilter = null,

    /// Indicates whether to include recommendations for resources in all member
    /// accounts of
    /// the organization if your account is the management account of an
    /// organization.
    ///
    /// The member accounts must also be opted in to Compute Optimizer, and trusted
    /// access for
    /// Compute Optimizer must be enabled in the organization account. For more
    /// information,
    /// see [Compute Optimizer and Amazon Web Services Organizations trusted
    /// access](https://docs.aws.amazon.com/compute-optimizer/latest/ug/security-iam.html#trusted-service-access) in the
    /// *Compute Optimizer User Guide*.
    ///
    /// If this parameter is omitted, recommendations for member accounts of the
    /// organization
    /// aren't included in the export file .
    ///
    /// This parameter cannot be specified together with the account IDs parameter.
    /// The
    /// parameters are mutually exclusive.
    include_member_accounts: ?bool = null,

    s_3_destination_config: S3DestinationConfig,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .fields_to_export = "fieldsToExport",
        .file_format = "fileFormat",
        .filters = "filters",
        .include_member_accounts = "includeMemberAccounts",
        .s_3_destination_config = "s3DestinationConfig",
    };
};

pub const ExportLicenseRecommendationsOutput = struct {
    /// The identification number of the export job.
    ///
    /// To view the status of an export job, use the
    /// DescribeRecommendationExportJobs
    /// action and specify the job ID.
    job_id: ?[]const u8 = null,

    s_3_destination: ?S3Destination = null,

    pub const json_field_names = .{
        .job_id = "jobId",
        .s_3_destination = "s3Destination",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExportLicenseRecommendationsInput, options: CallOptions) !ExportLicenseRecommendationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "compute-optimizer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ExportLicenseRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("compute-optimizer", "Compute Optimizer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerService.ExportLicenseRecommendations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExportLicenseRecommendationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ExportLicenseRecommendationsOutput, body, allocator);
}
