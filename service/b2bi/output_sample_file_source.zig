const S3Location = @import("s3_location.zig").S3Location;

/// Container for the location of a sample file used for outbound
/// transformations.
pub const OutputSampleFileSource = union(enum) {
    file_location: ?S3Location,

    pub const json_field_names = .{
        .file_location = "fileLocation",
    };
};
