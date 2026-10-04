/// An iterable form available on an asset, identified by its form type.
pub const IterableFormEntry = struct {
    /// The form type identifier of the iterable form (for example, `columns`), used
    /// to retrieve its items via `ListIterableForms` or `BatchGetIterableForms`.
    form_type_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .form_type_id = "FormTypeId",
    };
};
