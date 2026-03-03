const aws = @import("aws");
const std = @import("std");

const scan_sbom = @import("scan_sbom.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Inspector Scan";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Scans a provided CycloneDX 1.5 SBOM and reports on any vulnerabilities
    /// discovered in that SBOM. You can generate compatible SBOMs for your
    /// resources using the [Amazon Inspector SBOM
    /// generator](https://docs.aws.amazon.com/inspector/latest/user/sbom-generator.html).
    ///
    /// The output of this action reports NVD and CVSS scores when NVD and CVSS
    /// scores are available. Because the output reports both scores, you might
    /// notice a discrepency between them. However, you can triage the severity of
    /// either score depending on the vendor of your choosing.
    pub fn scanSbom(self: *Self, allocator: std.mem.Allocator, input: scan_sbom.ScanSbomInput, options: scan_sbom.Options) !scan_sbom.ScanSbomOutput {
        return scan_sbom.execute(self, allocator, input, options);
    }
};
