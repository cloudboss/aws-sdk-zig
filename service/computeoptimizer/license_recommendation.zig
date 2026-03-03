const LicenseConfiguration = @import("license_configuration.zig").LicenseConfiguration;
const LicenseFinding = @import("license_finding.zig").LicenseFinding;
const LicenseFindingReasonCode = @import("license_finding_reason_code.zig").LicenseFindingReasonCode;
const LicenseRecommendationOption = @import("license_recommendation_option.zig").LicenseRecommendationOption;
const Tag = @import("tag.zig").Tag;

/// Describes a license recommendation for an EC2 instance.
pub const LicenseRecommendation = struct {
    /// The Amazon Web Services account ID of the license.
    account_id: ?[]const u8 = null,

    /// An object that describes the current configuration of an instance that runs
    /// on a license.
    current_license_configuration: ?LicenseConfiguration = null,

    /// The finding classification for an instance that runs on a license.
    ///
    /// Findings include:
    ///
    /// * `InsufficentMetrics` — When Compute Optimizer detects that your CloudWatch
    /// Application Insights isn't enabled or is enabled with insufficient
    /// permissions.
    ///
    /// * `NotOptimized` — When Compute Optimizer detects that your EC2
    ///   infrastructure
    /// isn't using any of the SQL server license features you're paying for, a
    /// license is considered
    /// not optimized.
    ///
    /// * `Optimized` — When Compute Optimizer detects that all specifications of
    ///   your
    /// license meet the performance requirements of your workload.
    finding: ?LicenseFinding = null,

    /// The reason for the finding classification for an instance that runs on a
    /// license.
    ///
    /// Finding reason codes include:
    ///
    /// * `Optimized` — All specifications of your
    /// license meet the performance requirements of your workload.
    ///
    /// * `LicenseOverprovisioned` — A license is considered over-provisioned when
    ///   your license can be
    /// downgraded while still meeting the performance requirements of your
    /// workload.
    ///
    /// * `InvalidCloudwatchApplicationInsights` — CloudWatch
    /// Application Insights isn't configured properly.
    ///
    /// * `CloudwatchApplicationInsightsError` — There is a CloudWatch
    /// Application Insights error.
    finding_reason_codes: ?[]const LicenseFindingReasonCode = null,

    /// The timestamp of when the license recommendation was last generated.
    last_refresh_timestamp: ?i64 = null,

    /// An array of objects that describe the license recommendation options.
    license_recommendation_options: ?[]const LicenseRecommendationOption = null,

    /// The number of days for which utilization metrics were analyzed for an
    /// instance that runs on a license.
    lookback_period_in_days: f64 = 0,

    /// The ARN that identifies the Amazon EC2 instance.
    resource_arn: ?[]const u8 = null,

    /// A list of tags assigned to an EC2 instance.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .current_license_configuration = "currentLicenseConfiguration",
        .finding = "finding",
        .finding_reason_codes = "findingReasonCodes",
        .last_refresh_timestamp = "lastRefreshTimestamp",
        .license_recommendation_options = "licenseRecommendationOptions",
        .lookback_period_in_days = "lookbackPeriodInDays",
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
