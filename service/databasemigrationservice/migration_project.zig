const SCApplicationAttributes = @import("sc_application_attributes.zig").SCApplicationAttributes;
const DataProviderDescriptor = @import("data_provider_descriptor.zig").DataProviderDescriptor;

/// Provides information that defines a migration project.
pub const MigrationProject = struct {
    /// A user-friendly description of the migration project.
    description: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the instance profile for your migration
    /// project.
    instance_profile_arn: ?[]const u8,

    /// The name of the associated instance profile.
    instance_profile_name: ?[]const u8,

    /// The ARN string that uniquely identifies the migration project.
    migration_project_arn: ?[]const u8,

    /// The time when the migration project was created.
    migration_project_creation_time: ?i64,

    /// The name of the migration project.
    migration_project_name: ?[]const u8,

    /// The schema conversion application attributes, including the Amazon S3 bucket
    /// name and Amazon S3 role ARN.
    schema_conversion_application_attributes: ?SCApplicationAttributes,

    /// Information about the source data provider, including the name or ARN, and
    /// Secrets Manager parameters.
    source_data_provider_descriptors: ?[]const DataProviderDescriptor,

    /// Information about the target data provider, including the name or ARN, and
    /// Secrets Manager parameters.
    target_data_provider_descriptors: ?[]const DataProviderDescriptor,

    /// The settings in JSON format for migration rules. Migration rules make it
    /// possible for you to change
    /// the object names according to the rules that you specify. For example, you
    /// can change an object name
    /// to lowercase or uppercase, add or remove a prefix or suffix, or rename
    /// objects.
    transformation_rules: ?[]const u8,

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
