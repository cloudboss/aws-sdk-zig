/// The current status of an account as the delegated Amazon Macie administrator
/// account for an organization in Organizations. Possible values are:
pub const AdminStatus = enum {
    enabled,
    disabling_in_progress,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabling_in_progress = "DISABLING_IN_PROGRESS",
    };
};
