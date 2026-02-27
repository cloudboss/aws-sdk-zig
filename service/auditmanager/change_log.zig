const ActionEnum = @import("action_enum.zig").ActionEnum;
const ObjectTypeEnum = @import("object_type_enum.zig").ObjectTypeEnum;

/// The record of a change within Audit Manager. For example, this could be the
/// status change of an assessment or the delegation of a control set.
pub const ChangeLog = struct {
    /// The action that was performed.
    action: ?ActionEnum,

    /// The time when the action was performed and the changelog record was created.
    created_at: ?i64,

    /// The user or role that performed the action.
    created_by: ?[]const u8,

    /// The name of the object that changed. This could be the name of an
    /// assessment, control,
    /// or control set.
    object_name: ?[]const u8,

    /// The object that was changed, such as an assessment, control, or control set.
    object_type: ?ObjectTypeEnum,

    pub const json_field_names = .{
        .action = "action",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .object_name = "objectName",
        .object_type = "objectType",
    };
};
