const ApprovalConfiguration = @import("approval_configuration.zig").ApprovalConfiguration;

/// A wrapper for updating the approval configuration of a registry. Include
/// this wrapper to replace the approval configuration with the specified value;
/// omit it to leave the approval configuration unchanged.
pub const UpdatedApprovalConfiguration = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?ApprovalConfiguration = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
