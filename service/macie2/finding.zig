const FindingCategory = @import("finding_category.zig").FindingCategory;
const ClassificationDetails = @import("classification_details.zig").ClassificationDetails;
const PolicyDetails = @import("policy_details.zig").PolicyDetails;
const ResourcesAffected = @import("resources_affected.zig").ResourcesAffected;
const Severity = @import("severity.zig").Severity;
const FindingType = @import("finding_type.zig").FindingType;

/// Provides the details of a finding.
pub const Finding = struct {
    /// The unique identifier for the Amazon Web Services account that the finding
    /// applies to. This is typically the account that owns the affected resource.
    account_id: ?[]const u8,

    /// Specifies whether the finding is archived (suppressed).
    archived: ?bool,

    /// The category of the finding. Possible values are: CLASSIFICATION, for a
    /// sensitive data finding; and, POLICY, for a policy finding.
    category: ?FindingCategory,

    /// The details of a sensitive data finding. This value is null for a policy
    /// finding.
    classification_details: ?ClassificationDetails,

    /// The total number of occurrences of the finding. For sensitive data findings,
    /// this value is always 1. All sensitive data findings are considered unique.
    count: ?i64,

    /// The date and time, in UTC and extended ISO 8601 format, when Amazon Macie
    /// created the finding.
    created_at: ?i64,

    /// The description of the finding.
    description: ?[]const u8,

    /// The unique identifier for the finding. This is a random string that Amazon
    /// Macie generates and assigns to a finding when it creates the finding.
    id: ?[]const u8,

    /// The Amazon Web Services partition that Amazon Macie created the finding in.
    partition: ?[]const u8,

    /// The details of a policy finding. This value is null for a sensitive data
    /// finding.
    policy_details: ?PolicyDetails,

    /// The Amazon Web Services Region that Amazon Macie created the finding in.
    region: ?[]const u8,

    /// The resources that the finding applies to.
    resources_affected: ?ResourcesAffected,

    /// Specifies whether the finding is a sample finding. A *sample finding* is a
    /// finding that uses example data to demonstrate what a finding might contain.
    sample: ?bool,

    /// The version of the schema that was used to define the data structures in the
    /// finding.
    schema_version: ?[]const u8,

    /// The severity level and score for the finding.
    severity: ?Severity,

    /// The brief description of the finding.
    title: ?[]const u8,

    /// The type of the finding.
    type: ?FindingType,

    /// The date and time, in UTC and extended ISO 8601 format, when Amazon Macie
    /// last updated the finding. For sensitive data findings, this value is the
    /// same as the value for the createdAt property. All sensitive data findings
    /// are considered new.
    updated_at: ?i64,

    pub const json_field_names = .{
        .account_id = "accountId",
        .archived = "archived",
        .category = "category",
        .classification_details = "classificationDetails",
        .count = "count",
        .created_at = "createdAt",
        .description = "description",
        .id = "id",
        .partition = "partition",
        .policy_details = "policyDetails",
        .region = "region",
        .resources_affected = "resourcesAffected",
        .sample = "sample",
        .schema_version = "schemaVersion",
        .severity = "severity",
        .title = "title",
        .type = "type",
        .updated_at = "updatedAt",
    };
};
