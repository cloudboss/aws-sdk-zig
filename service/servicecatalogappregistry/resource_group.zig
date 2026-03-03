const ResourceGroupState = @import("resource_group_state.zig").ResourceGroupState;

/// The information about the resource group integration.
pub const ResourceGroup = struct {
    /// The Amazon resource name (ARN) of the resource group.
    arn: ?[]const u8 = null,

    /// The error message that generates when the propagation process for the
    /// resource group fails.
    error_message: ?[]const u8 = null,

    /// The state of the propagation process for the resource group. The states
    /// includes:
    ///
    /// `CREATING `if the resource group is in the process of being created.
    ///
    /// `CREATE_COMPLETE` if the resource group was created successfully.
    ///
    /// `CREATE_FAILED` if the resource group failed to be created.
    ///
    /// `UPDATING` if the resource group is in the process of being updated.
    ///
    /// `UPDATE_COMPLETE` if the resource group updated successfully.
    ///
    /// `UPDATE_FAILED` if the resource group could not update successfully.
    state: ?ResourceGroupState = null,

    pub const json_field_names = .{
        .arn = "arn",
        .error_message = "errorMessage",
        .state = "state",
    };
};
