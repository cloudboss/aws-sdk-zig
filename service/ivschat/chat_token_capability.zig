pub const ChatTokenCapability = enum {
    send_message,
    disconnect_user,
    delete_message,

    pub const json_field_names = .{
        .send_message = "SEND_MESSAGE",
        .disconnect_user = "DISCONNECT_USER",
        .delete_message = "DELETE_MESSAGE",
    };
};
