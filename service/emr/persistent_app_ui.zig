const PersistentAppUIType = @import("persistent_app_ui_type.zig").PersistentAppUIType;
const Tag = @import("tag.zig").Tag;

/// Holds persistent application user interface information. Applications
/// installed on the Amazon EMR cluster publish user interfaces as
/// web sites to monitor cluster activity.
pub const PersistentAppUI = struct {
    /// The author ID for the persistent application user interface object.
    author_id: ?[]const u8,

    /// The creation date and time for the persistent application user interface
    /// object.
    creation_time: ?i64,

    /// The date and time the persistent application user interface object was last
    /// changed.
    last_modified_time: ?i64,

    /// The reason the persistent application user interface object was last
    /// changed.
    last_state_change_reason: ?[]const u8,

    /// The identifier for the persistent application user interface object.
    persistent_app_ui_id: ?[]const u8,

    /// The status for the persistent application user interface object.
    persistent_app_ui_status: ?[]const u8,

    /// The type list for the persistent application user interface object. Valid
    /// values
    /// include SHS, YTS, or TEZ.
    persistent_app_ui_type_list: ?[]const PersistentAppUIType,

    /// A collection of tags for the persistent application user interface object.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .author_id = "AuthorId",
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .last_state_change_reason = "LastStateChangeReason",
        .persistent_app_ui_id = "PersistentAppUIId",
        .persistent_app_ui_status = "PersistentAppUIStatus",
        .persistent_app_ui_type_list = "PersistentAppUITypeList",
        .tags = "Tags",
    };
};
