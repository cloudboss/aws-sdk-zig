const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// The settings that apply to an Amazon SageMaker AI domain when you use it in
/// Amazon SageMaker Unified Studio.
pub const UnifiedStudioSettings = struct {
    /// The ID of the Amazon Web Services account that has the Amazon SageMaker
    /// Unified Studio domain. The default value, if you don't specify an ID, is the
    /// ID of the account that has the Amazon SageMaker AI domain.
    domain_account_id: ?[]const u8 = null,

    /// The ID of the Amazon SageMaker Unified Studio domain associated with this
    /// domain.
    domain_id: ?[]const u8 = null,

    /// The Amazon Web Services Region where the domain is located in Amazon
    /// SageMaker Unified Studio. The default value, if you don't specify a Region,
    /// is the Region where the Amazon SageMaker AI domain is located.
    domain_region: ?[]const u8 = null,

    /// The ID of the environment that Amazon SageMaker Unified Studio associates
    /// with the domain.
    environment_id: ?[]const u8 = null,

    /// The ID of the Amazon SageMaker Unified Studio project that corresponds to
    /// the domain.
    project_id: ?[]const u8 = null,

    /// The location where Amazon S3 stores temporary execution data and other
    /// artifacts for the project that corresponds to the domain.
    project_s3_path: ?[]const u8 = null,

    /// The ARN of the Amazon DataZone application managed by Amazon SageMaker
    /// Unified Studio in the Amazon Web Services IAM Identity Center.
    single_sign_on_application_arn: ?[]const u8 = null,

    /// Sets whether you can access the domain in Amazon SageMaker Studio:
    ///
    /// **ENABLED**
    ///
    /// You can access the domain in Amazon SageMaker Studio. If you migrate the
    /// domain to Amazon SageMaker Unified Studio, you can access it in both studio
    /// interfaces.
    ///
    /// **DISABLED**
    ///
    /// You can't access the domain in Amazon SageMaker Studio. If you migrate the
    /// domain to Amazon SageMaker Unified Studio, you can access it only in that
    /// studio interface.
    ///
    /// To migrate a domain to Amazon SageMaker Unified Studio, you specify the
    /// UnifiedStudioSettings data type when you use the UpdateDomain action.
    studio_web_portal_access: ?FeatureStatus = null,

    pub const json_field_names = .{
        .domain_account_id = "DomainAccountId",
        .domain_id = "DomainId",
        .domain_region = "DomainRegion",
        .environment_id = "EnvironmentId",
        .project_id = "ProjectId",
        .project_s3_path = "ProjectS3Path",
        .single_sign_on_application_arn = "SingleSignOnApplicationArn",
        .studio_web_portal_access = "StudioWebPortalAccess",
    };
};
