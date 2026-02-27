pub const CaseEditItem = struct {
    action: ?[]const u8,

    event_timestamp: ?i64,

    message: ?[]const u8,

    principal: ?[]const u8,

    pub const json_field_names = .{
        .action = "action",
        .event_timestamp = "eventTimestamp",
        .message = "message",
        .principal = "principal",
    };
};
