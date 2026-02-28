const SourceConnectionParameters = @import("source_connection_parameters.zig").SourceConnectionParameters;
const LastSync = @import("last_sync.zig").LastSync;
const SourceType = @import("source_type.zig").SourceType;

/// Provides details about the configured `SourceConnection`.
pub const SourceConnectionDetail = struct {
    /// The connection details based on the connection `Type`.
    connection_parameters: ?SourceConnectionParameters,

    /// Provides details about the product's connection sync and contains the
    /// following sub-fields.
    ///
    /// * `LastSyncTime`
    ///
    /// * `LastSyncStatus`
    ///
    /// * `LastSyncStatusMessage`
    ///
    /// * `LastSuccessfulSyncTime`
    ///
    /// * `LastSuccessfulSyncProvisioningArtifactID`
    last_sync: ?LastSync,

    /// The only supported `SourceConnection` type is Codestar.
    @"type": ?SourceType,

    pub const json_field_names = .{
        .connection_parameters = "ConnectionParameters",
        .last_sync = "LastSync",
        .@"type" = "Type",
    };
};
