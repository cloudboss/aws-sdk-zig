pub const CaseEditItem = struct {
    action: ?[]const u8 = null,

    event_timestamp: ?i64 = null,

    message: ?[]const u8 = null,

    principal: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "action",
        .event_timestamp = "eventTimestamp",
        .message = "message",
        .principal = "principal",
    };
};
