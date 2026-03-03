const LayerFailureCode = @import("layer_failure_code.zig").LayerFailureCode;

/// An object representing an Amazon ECR image layer failure.
pub const LayerFailure = struct {
    /// The failure code associated with the failure.
    failure_code: ?LayerFailureCode = null,

    /// The reason for the failure.
    failure_reason: ?[]const u8 = null,

    /// The layer digest associated with the failure.
    layer_digest: ?[]const u8 = null,

    pub const json_field_names = .{
        .failure_code = "failureCode",
        .failure_reason = "failureReason",
        .layer_digest = "layerDigest",
    };
};
