pub const ContactMediaProcessingFailureMode = enum {
    deliver_unprocessed_message,
    do_not_deliver_unprocessed_message,

    pub const json_field_names = .{
        .deliver_unprocessed_message = "DELIVER_UNPROCESSED_MESSAGE",
        .do_not_deliver_unprocessed_message = "DO_NOT_DELIVER_UNPROCESSED_MESSAGE",
    };
};
