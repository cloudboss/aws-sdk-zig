/// Contains output information for protected queries with an S3 output type.
pub const ProtectedQueryS3Output = struct {
    /// The S3 location of the result.
    location: []const u8,

    pub const json_field_names = .{
        .location = "location",
    };
};
