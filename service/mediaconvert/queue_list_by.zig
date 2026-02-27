/// Optional. When you request a list of queues, you can choose to list them
/// alphabetically by NAME or chronologically by CREATION_DATE. If you don't
/// specify, the service will list them by creation date.
pub const QueueListBy = enum {
    name,
    creation_date,

    pub const json_field_names = .{
        .name = "NAME",
        .creation_date = "CREATION_DATE",
    };
};
