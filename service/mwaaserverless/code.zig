const S3Location = @import("s3_location.zig").S3Location;

/// Specifies the Amazon S3 location of code artifacts that workflows use during
/// execution.
pub const Code = union(enum) {
    /// The Amazon S3 location of the code artifacts that your workflow tasks use
    /// during execution.
    s3_location: ?S3Location,

    pub const json_field_names = .{
        .s3_location = "S3Location",
    };
};
