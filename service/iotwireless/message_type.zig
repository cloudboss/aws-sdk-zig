/// Sidewalk device message type. Default value is
/// `CUSTOM_COMMAND_ID_NOTIFY`.
pub const MessageType = enum {
    custom_command_id_notify,
    custom_command_id_get,
    custom_command_id_set,
    custom_command_id_resp,

    pub const json_field_names = .{
        .custom_command_id_notify = "CUSTOM_COMMAND_ID_NOTIFY",
        .custom_command_id_get = "CUSTOM_COMMAND_ID_GET",
        .custom_command_id_set = "CUSTOM_COMMAND_ID_SET",
        .custom_command_id_resp = "CUSTOM_COMMAND_ID_RESP",
    };
};
