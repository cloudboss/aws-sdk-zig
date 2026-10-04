const S3Destination = @import("s3_destination.zig").S3Destination;

/// The output location for a notebook export in Amazon SageMaker Unified
/// Studio.
pub const OutputLocation = union(enum) {
    /// The Amazon Simple Storage Service destination for the notebook export.
    s_3: ?S3Destination,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
