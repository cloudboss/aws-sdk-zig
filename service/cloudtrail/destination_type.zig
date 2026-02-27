pub const DestinationType = enum {
    event_data_store,
    aws_service,

    pub const json_field_names = .{
        .event_data_store = "EVENT_DATA_STORE",
        .aws_service = "AWS_SERVICE",
    };
};
