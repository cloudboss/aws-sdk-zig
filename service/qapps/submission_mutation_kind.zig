pub const SubmissionMutationKind = enum {
    edit,
    delete,
    add,

    pub const json_field_names = .{
        .edit = "edit",
        .delete = "delete",
        .add = "add",
    };
};
