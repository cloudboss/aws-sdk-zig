const SCApplicationAttributes = @import("sc_application_attributes.zig").SCApplicationAttributes;
const DataProviderDescriptor = @import("data_provider_descriptor.zig").DataProviderDescriptor;

/// Provides information that defines a migration project.
pub const MigrationProject = struct {
    /// A user-friendly description of the migration project.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the instance profile for your migration
    /// project.
    instance_profile_arn: ?[]const u8 = null,

    /// The name of the associated instance profile.
    instance_profile_name: ?[]const u8 = null,

    /// The ARN string that uniquely identifies the migration project.
    migration_project_arn: ?[]const u8 = null,

    /// The time when the migration project was created.
    migration_project_creation_time: ?i64 = null,

    /// The name of the migration project.
    migration_project_name: ?[]const u8 = null,

    /// The schema conversion application attributes, including the Amazon S3 bucket
    /// name and Amazon S3 role ARN.
    schema_conversion_application_attributes: ?SCApplicationAttributes = null,

    /// Information about the source data provider, including the name or ARN, and
    /// Secrets Manager parameters.
    source_data_provider_descriptors: ?[]const DataProviderDescriptor = null,

    /// Information about the target data provider, including the name or ARN, and
    /// Secrets Manager parameters.
    target_data_provider_descriptors: ?[]const DataProviderDescriptor = null,

    /// The transformation rules for the migration project in JSON format.
    /// Transformation rules let you customize how DMS Schema Conversion converts
    /// your source
    /// database objects, including renaming, adding prefixes or suffixes, and
    /// changing data types.
    /// For the transformation rule format and examples, see [Transformation rules
    /// in DMS
    /// Schema
    /// Conversion](https://docs.aws.amazon.com/dms/latest/userguide/sc-transformation-rules.html).
    ///
    /// Homogeneous data migrations do not support transformation rules.
    transformation_rules: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .instance_profile_arn = "InstanceProfileArn",
        .instance_profile_name = "InstanceProfileName",
        .migration_project_arn = "MigrationProjectArn",
        .migration_project_creation_time = "MigrationProjectCreationTime",
        .migration_project_name = "MigrationProjectName",
        .schema_conversion_application_attributes = "SchemaConversionApplicationAttributes",
        .source_data_provider_descriptors = "SourceDataProviderDescriptors",
        .target_data_provider_descriptors = "TargetDataProviderDescriptors",
        .transformation_rules = "TransformationRules",
    };
};
