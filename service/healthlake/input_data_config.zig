/// The import job input properties.
pub const InputDataConfig = union(enum) {
    /// The `S3Uri` is the user-specified S3 location of the FHIR data to be
    /// imported into AWS HealthLake.
    s3_uri: ?[]const u8,

    pub const json_field_names = .{
        .s3_uri = "S3Uri",
    };
};
