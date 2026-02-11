pub const InvocationType = enum {
    event,
    request_response,
    dry_run,

    pub const json_field_names = .{
        .event = "Event",
        .request_response = "RequestResponse",
        .dry_run = "DryRun",
    };
};
