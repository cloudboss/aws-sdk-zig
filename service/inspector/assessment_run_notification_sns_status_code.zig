pub const AssessmentRunNotificationSnsStatusCode = enum {
    success,
    topic_does_not_exist,
    access_denied,
    internal_error,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .topic_does_not_exist = "TOPIC_DOES_NOT_EXIST",
        .access_denied = "ACCESS_DENIED",
        .internal_error = "INTERNAL_ERROR",
    };
};
