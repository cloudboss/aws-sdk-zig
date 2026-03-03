const CreateGlobalSecondaryIndexAction = @import("create_global_secondary_index_action.zig").CreateGlobalSecondaryIndexAction;
const DeleteGlobalSecondaryIndexAction = @import("delete_global_secondary_index_action.zig").DeleteGlobalSecondaryIndexAction;
const UpdateGlobalSecondaryIndexAction = @import("update_global_secondary_index_action.zig").UpdateGlobalSecondaryIndexAction;

/// Represents one of the following:
///
/// * A new global secondary index to be added to an existing table.
///
/// * New provisioned throughput parameters for an existing global secondary
/// index.
///
/// * An existing global secondary index to be removed from an existing
/// table.
pub const GlobalSecondaryIndexUpdate = struct {
    /// The parameters required for creating a global secondary index on an existing
    /// table:
    ///
    /// * `IndexName `
    ///
    /// * `KeySchema `
    ///
    /// * `AttributeDefinitions `
    ///
    /// * `Projection `
    ///
    /// * `ProvisionedThroughput `
    create: ?CreateGlobalSecondaryIndexAction = null,

    /// The name of an existing global secondary index to be removed.
    delete: ?DeleteGlobalSecondaryIndexAction = null,

    /// The name of an existing global secondary index, along with new provisioned
    /// throughput
    /// settings to be applied to that index.
    update: ?UpdateGlobalSecondaryIndexAction = null,

    pub const json_field_names = .{
        .create = "Create",
        .delete = "Delete",
        .update = "Update",
    };
};
