/// The state of a configuration.
pub const ConfigurationState = enum {
    active,
    deleting,
    delete_failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
    };
};
