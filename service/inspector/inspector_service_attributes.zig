/// This data type is used in the Finding data type.
pub const InspectorServiceAttributes = struct {
    /// The ARN of the assessment run during which the finding is generated.
    assessment_run_arn: ?[]const u8 = null,

    /// The ARN of the rules package that is used to generate the finding.
    rules_package_arn: ?[]const u8 = null,

    /// The schema version of this data type.
    schema_version: i32 = 0,

    pub const json_field_names = .{
        .assessment_run_arn = "assessmentRunArn",
        .rules_package_arn = "rulesPackageArn",
        .schema_version = "schemaVersion",
    };
};
