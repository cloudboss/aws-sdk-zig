const aws = @import("aws");
const std = @import("std");

const scan_sbom = @import("scan_sbom.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Inspector Scan";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
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
    pub fn scanSbom(self: *Self, allocator: std.mem.Allocator, input: scan_sbom.ScanSbomInput, options: CallOptions) !scan_sbom.ScanSbomOutput {
        return scan_sbom.execute(self, allocator, input, options);
    }
};
