pub const ContactListImportAction = enum {
    delete,
    put,

    pub const json_field_names = .{
        .delete = "DELETE",
        .put = "PUT",
    };
};
