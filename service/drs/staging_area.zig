const ExtensionStatus = @import("extension_status.zig").ExtensionStatus;

/// Staging information related to source server.
pub const StagingArea = struct {
    /// Shows an error message that occurred when DRS tried to access the staging
    /// source server. In this case StagingArea$status will have value
    /// EXTENSION_ERROR
    error_message: ?[]const u8 = null,

    /// Account ID of the account to which source server belongs. If this source
    /// server is extended - shows Account ID of staging source server.
    staging_account_id: ?[]const u8 = null,

    /// Arn of the staging source server if this source server is extended
    staging_source_server_arn: ?[]const u8 = null,

    /// Status of Source server extension. Possible values: (a) NOT_EXTENDED - This
    /// is a source server that is replicating in the current account. (b) EXTENDED
    /// - Source server is extended from a staging source server. In this case, the
    /// value of stagingSourceServerArn is pointing to the Arn of the source server
    /// in the staging account. (c) EXTENSION_ERROR - Some issue occurred when
    /// accessing staging source server. In this case, errorMessage field will
    /// contain an error message that explains what happened.
    status: ?ExtensionStatus = null,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .staging_account_id = "stagingAccountID",
        .staging_source_server_arn = "stagingSourceServerArn",
        .status = "status",
    };
};
