pub const PublishingStatus = enum {
    pending_verification,
    publishing,
    unable_to_publish_fix_destination_property,
    stopped,

    pub const json_field_names = .{
        .pending_verification = "PENDING_VERIFICATION",
        .publishing = "PUBLISHING",
        .unable_to_publish_fix_destination_property = "UNABLE_TO_PUBLISH_FIX_DESTINATION_PROPERTY",
        .stopped = "STOPPED",
    };
};
