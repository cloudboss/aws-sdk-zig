const EncryptedLogGroupStrategy = @import("encrypted_log_group_strategy.zig").EncryptedLogGroupStrategy;

/// Configuration for selecting and handling source log groups for
/// centralization.
pub const SourceLogsConfiguration = struct {
    /// The selection criteria that specifies which data sources to centralize. The
    /// selection criteria uses the same filter expression format as
    /// `LogGroupSelectionCriteria`, but operates on `DataSourceName` and
    /// `DataSourceType` operands. When both `LogGroupSelectionCriteria` and
    /// `DataSourceSelectionCriteria` are specified, a log event must match both
    /// criteria to be centralized.
    data_source_selection_criteria: ?[]const u8 = null,

    /// A strategy determining whether to centralize source log groups that are
    /// encrypted with customer managed KMS keys (CMK). ALLOW will consider CMK
    /// encrypted source log groups for centralization while SKIP will skip CMK
    /// encrypted source log groups from centralization.
    encrypted_log_group_strategy: EncryptedLogGroupStrategy,

    /// The selection criteria that specifies which source log groups to centralize.
    /// The selection criteria uses the same format as OAM link filters.
    log_group_selection_criteria: []const u8 = "*",

    pub const json_field_names = .{
        .data_source_selection_criteria = "DataSourceSelectionCriteria",
        .encrypted_log_group_strategy = "EncryptedLogGroupStrategy",
        .log_group_selection_criteria = "LogGroupSelectionCriteria",
    };
};
