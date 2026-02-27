const ImageFailureCode = @import("image_failure_code.zig").ImageFailureCode;
const ImageIdentifier = @import("image_identifier.zig").ImageIdentifier;

/// An object representing an Amazon ECR image failure.
pub const ImageFailure = struct {
    /// The code associated with the failure.
    failure_code: ?ImageFailureCode,

    /// The reason for the failure.
    failure_reason: ?[]const u8,

    /// The image ID associated with the failure.
    image_id: ?ImageIdentifier,

    pub const json_field_names = .{
        .failure_code = "failureCode",
        .failure_reason = "failureReason",
        .image_id = "imageId",
    };
};
