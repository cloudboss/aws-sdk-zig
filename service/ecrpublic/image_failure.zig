const ImageFailureCode = @import("image_failure_code.zig").ImageFailureCode;
const ImageIdentifier = @import("image_identifier.zig").ImageIdentifier;

/// An object that represents an Amazon ECR image failure.
pub const ImageFailure = struct {
    /// The code that's associated with the failure.
    failure_code: ?ImageFailureCode = null,

    /// The reason for the failure.
    failure_reason: ?[]const u8 = null,

    /// The image ID that's associated with the failure.
    image_id: ?ImageIdentifier = null,

    pub const json_field_names = .{
        .failure_code = "failureCode",
        .failure_reason = "failureReason",
        .image_id = "imageId",
    };
};
