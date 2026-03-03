/// The Lake Formation configuration of the Data Lake blueprint.
pub const LakeFormationConfiguration = struct {
    /// Specifies certain Amazon S3 locations if you do not want Amazon DataZone to
    /// automatically register them in hybrid mode.
    location_registration_exclude_s3_locations: ?[]const []const u8 = null,

    /// The role that is used to manage read/write access to the chosen Amazon S3
    /// bucket(s) for Data Lake using Amazon Web Services Lake Formation hybrid
    /// access mode.
    location_registration_role: ?[]const u8 = null,

    pub const json_field_names = .{
        .location_registration_exclude_s3_locations = "locationRegistrationExcludeS3Locations",
        .location_registration_role = "locationRegistrationRole",
    };
};
