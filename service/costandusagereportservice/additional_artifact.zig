/// The types of manifest that you want Amazon Web Services to create for this
/// report.
pub const AdditionalArtifact = enum {
    redshift,
    quicksight,
    athena,

    pub const json_field_names = .{
        .redshift = "REDSHIFT",
        .quicksight = "QUICKSIGHT",
        .athena = "ATHENA",
    };
};
