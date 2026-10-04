/// The metadata of the remediation guidance.
pub const RemediationGuidanceMetadata = struct {
    /// The extent to which the guidance can be automated, for example `Full`.
    automation_level: ?[]const u8 = null,

    /// The exposure type of the related exposure findings.
    exposure_type: []const u8,

    /// When the fix takes effect, for example `Immediate` or `Deferred`.
    fix_effect: []const u8,

    /// Timestamp of when the guidance was generated.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    generated_at: ?i64 = null,

    /// Specifies whether human review is required.
    human_review_required: ?bool = null,

    /// The resource type of the remediation target.
    resource_type: []const u8,

    /// The extent to which changes made in accordance with the guidance can be
    /// reversed, for example `Fully reversible`.
    reversibility: []const u8,

    /// The risk when implementing the guidance provided.
    risk_level: []const u8,

    /// The titles of traits this guidance applies to.
    trait_titles: []const []const u8,

    /// Verification status of the guidance.
    verification_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .automation_level = "AutomationLevel",
        .exposure_type = "ExposureType",
        .fix_effect = "FixEffect",
        .generated_at = "GeneratedAt",
        .human_review_required = "HumanReviewRequired",
        .resource_type = "ResourceType",
        .reversibility = "Reversibility",
        .risk_level = "RiskLevel",
        .trait_titles = "TraitTitles",
        .verification_status = "VerificationStatus",
    };
};
