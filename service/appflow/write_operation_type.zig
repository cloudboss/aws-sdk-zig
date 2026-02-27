/// The possible write operations in the destination connector. When this value
/// is not
/// provided, this defaults to the `INSERT` operation.
pub const WriteOperationType = enum {
    insert,
    upsert,
    update,
    delete,

    pub const json_field_names = .{
        .insert = "INSERT",
        .upsert = "UPSERT",
        .update = "UPDATE",
        .delete = "DELETE",
    };
};
