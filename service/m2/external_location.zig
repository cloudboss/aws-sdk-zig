/// Defines an external storage location.
pub const ExternalLocation = union(enum) {
    /// The URI of the Amazon S3 bucket.
    s_3_location: ?[]const u8,

    pub const json_field_names = .{
        .s_3_location = "s3Location",
    };
};
