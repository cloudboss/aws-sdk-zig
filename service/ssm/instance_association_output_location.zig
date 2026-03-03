const S3OutputLocation = @import("s3_output_location.zig").S3OutputLocation;

/// An S3 bucket where you want to store the results of this request.
///
/// For the minimal permissions required to enable Amazon S3 output for an
/// association,
/// see [Create an association
/// (console)](https://docs.aws.amazon.com/systems-manager/latest/userguide/state-manager-associations-creating.html#state-manager-associations-console) in the *Systems Manager User Guide*.
pub const InstanceAssociationOutputLocation = struct {
    /// An S3 bucket where you want to store the results of this request.
    s3_location: ?S3OutputLocation = null,

    pub const json_field_names = .{
        .s3_location = "S3Location",
    };
};
