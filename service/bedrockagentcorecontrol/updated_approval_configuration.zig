const ApprovalConfiguration = @import("approval_configuration.zig").ApprovalConfiguration;

/// Wrapper for updating an optional approval configuration field with PATCH
/// semantics. When present in an update request, the approval configuration is
/// replaced with the provided value. When absent, the approval configuration is
/// left unchanged.
pub const UpdatedApprovalConfiguration = struct {
    /// The updated approval configuration value. Set to `null` to unset the
    /// approval configuration.
    optional_value: ?ApprovalConfiguration = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
