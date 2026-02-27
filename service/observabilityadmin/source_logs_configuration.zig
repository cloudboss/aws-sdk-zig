const EncryptedLogGroupStrategy = @import("encrypted_log_group_strategy.zig").EncryptedLogGroupStrategy;

/// Configuration for selecting and handling source log groups for
/// centralization.
pub const SourceLogsConfiguration = struct {
    /// A strategy determining whether to centralize source log groups that are
    /// encrypted with customer managed KMS keys (CMK). ALLOW will consider CMK
    /// encrypted source log groups for centralization while SKIP will skip CMK
    /// encrypted source log groups from centralization.
    encrypted_log_group_strategy: EncryptedLogGroupStrategy,

    /// The selection criteria that specifies which source log groups to centralize.
    /// The selection criteria uses the same format as OAM link filters.
    log_group_selection_criteria: []const u8,

    pub const json_field_names = .{
        .encrypted_log_group_strategy = "EncryptedLogGroupStrategy",
        .log_group_selection_criteria = "LogGroupSelectionCriteria",
    };
};
