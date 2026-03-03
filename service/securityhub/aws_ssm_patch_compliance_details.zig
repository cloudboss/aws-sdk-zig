const AwsSsmPatch = @import("aws_ssm_patch.zig").AwsSsmPatch;

/// Provides information about the state of a patch on an instance based on the
/// patch
/// baseline that was used to patch the instance.
pub const AwsSsmPatchComplianceDetails = struct {
    /// Information about the status of a patch.
    patch: ?AwsSsmPatch = null,

    pub const json_field_names = .{
        .patch = "Patch",
    };
};
