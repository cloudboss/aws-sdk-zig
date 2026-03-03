/// Information about the server configured for source code analysis.
pub const RemoteSourceCodeAnalysisServerInfo = struct {
    /// The time when the remote source code server was configured.
    remote_source_code_analysis_server_configuration_timestamp: ?[]const u8 = null,

    pub const json_field_names = .{
        .remote_source_code_analysis_server_configuration_timestamp = "remoteSourceCodeAnalysisServerConfigurationTimestamp",
    };
};
