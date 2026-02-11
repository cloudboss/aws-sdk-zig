pub const ResponseStreamingInvocationType = enum {
    request_response,
    dry_run,

    pub const json_field_names = .{
        .request_response = "RequestResponse",
        .dry_run = "DryRun",
    };
};
