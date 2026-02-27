/// The type of action to perform on the address. The following are possible
/// values:
///
/// * PUT: add the addresses to the suppression list.
///
/// * DELETE: remove the address from the suppression list.
pub const SuppressionListImportAction = enum {
    delete,
    put,

    pub const json_field_names = .{
        .delete = "DELETE",
        .put = "PUT",
    };
};
