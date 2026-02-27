/// Contains output information for protected jobs with an S3 output type.
pub const ProtectedJobS3Output = struct {
    /// The S3 location for the protected job output.
    location: []const u8,

    pub const json_field_names = .{
        .location = "location",
    };
};
