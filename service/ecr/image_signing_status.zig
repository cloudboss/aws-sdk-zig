const SigningStatus = @import("signing_status.zig").SigningStatus;

/// The signing status for an image. Each status corresponds to a signing
/// profile.
pub const ImageSigningStatus = struct {
    /// The failure code, which is only present if `status`
    /// is `FAILED`.
    failure_code: ?[]const u8 = null,

    /// A description of why signing the image failed. This field is only
    /// present if `status` is `FAILED`.
    failure_reason: ?[]const u8 = null,

    /// The ARN of the Amazon Web Services Signer signing profile used to sign the
    /// image.
    signing_profile_arn: ?[]const u8 = null,

    /// The image's signing status. Possible values are:
    ///
    /// * `IN_PROGRESS` - Signing is currently in progress.
    ///
    /// * `COMPLETE` - The signature was successfully generated.
    ///
    /// * `FAILED` - Signing failed. See
    /// `failureCode` and `failureReason` for details.
    status: ?SigningStatus = null,

    pub const json_field_names = .{
        .failure_code = "failureCode",
        .failure_reason = "failureReason",
        .signing_profile_arn = "signingProfileArn",
        .status = "status",
    };
};
