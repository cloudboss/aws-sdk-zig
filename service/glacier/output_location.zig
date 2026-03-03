const S3Location = @import("s3_location.zig").S3Location;

/// Contains information about the location where the select job results are
/// stored.
pub const OutputLocation = struct {
    /// Describes an S3 location that will receive the results of the job request.
    s3: ?S3Location = null,

    pub const json_field_names = .{
        .s3 = "S3",
    };
};
