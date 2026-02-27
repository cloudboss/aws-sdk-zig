const SuppressionListImportAction = @import("suppression_list_import_action.zig").SuppressionListImportAction;

/// An object that contains details about the action of suppression list.
pub const SuppressionListDestination = struct {
    /// The type of action to perform on the address. The following are possible
    /// values:
    ///
    /// * PUT: add the addresses to the suppression list. If the record already
    ///   exists,
    /// it will override it with the new value.
    ///
    /// * DELETE: remove the addresses from the suppression list.
    suppression_list_import_action: SuppressionListImportAction,

    pub const json_field_names = .{
        .suppression_list_import_action = "SuppressionListImportAction",
    };
};
