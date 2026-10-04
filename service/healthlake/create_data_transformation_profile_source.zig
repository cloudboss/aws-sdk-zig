const ExistingVersionedProfileSource = @import("existing_versioned_profile_source.zig").ExistingVersionedProfileSource;
const ProfileMappingSource = @import("profile_mapping_source.zig").ProfileMappingSource;
const SampleDataSource = @import("sample_data_source.zig").SampleDataSource;
const StarterProfileSource = @import("starter_profile_source.zig").StarterProfileSource;

/// The source for initial content when creating a data transformation profile.
/// Specify exactly one variant: a built-in starter profile, an existing profile
/// version to clone, raw profile content, or a sample data file.
pub const CreateDataTransformationProfileSource = union(enum) {
    /// Creates the profile by cloning an existing profile at a specific version.
    existing_versioned_profile_id: ?ExistingVersionedProfileSource,
    /// Creates the profile from raw profile content that you provide directly. Use
    /// this variant for continuous integration and continuous delivery (CI/CD)
    /// workflows.
    profile_mapping: ?ProfileMappingSource,
    /// Creates the profile from a sample data file stored in Amazon S3. Valid only
    /// when the source format is Comma-separated values (CSV).
    sample_data: ?SampleDataSource,
    /// Creates the profile from a built-in starter profile. Valid only when the
    /// source format is Consolidated Clinical Document Architecture (C-CDA).
    starter_profile: ?StarterProfileSource,

    pub const json_field_names = .{
        .existing_versioned_profile_id = "ExistingVersionedProfileId",
        .profile_mapping = "ProfileMapping",
        .sample_data = "SampleData",
        .starter_profile = "StarterProfile",
    };
};
