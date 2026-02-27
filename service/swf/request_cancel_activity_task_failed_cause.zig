pub const RequestCancelActivityTaskFailedCause = enum {
    activity_id_unknown,
    operation_not_permitted,

    pub const json_field_names = .{
        .activity_id_unknown = "ACTIVITY_ID_UNKNOWN",
        .operation_not_permitted = "OPERATION_NOT_PERMITTED",
    };
};
