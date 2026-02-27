const IPAddressBasedRemoteInfo = @import("ip_address_based_remote_info.zig").IPAddressBasedRemoteInfo;
const PipelineInfo = @import("pipeline_info.zig").PipelineInfo;
const RemoteSourceCodeAnalysisServerInfo = @import("remote_source_code_analysis_server_info.zig").RemoteSourceCodeAnalysisServerInfo;
const VcenterBasedRemoteInfo = @import("vcenter_based_remote_info.zig").VcenterBasedRemoteInfo;
const VersionControlInfo = @import("version_control_info.zig").VersionControlInfo;

/// Summary of the collector configuration.
pub const ConfigurationSummary = struct {
    /// IP address based configurations.
    ip_address_based_remote_info_list: ?[]const IPAddressBasedRemoteInfo,

    /// The list of pipeline info configurations.
    pipeline_info_list: ?[]const PipelineInfo,

    /// Info about the remote server source code configuration.
    remote_source_code_analysis_server_info: ?RemoteSourceCodeAnalysisServerInfo,

    /// The list of vCenter configurations.
    vcenter_based_remote_info_list: ?[]const VcenterBasedRemoteInfo,

    /// The list of the version control configurations.
    version_control_info_list: ?[]const VersionControlInfo,

    pub const json_field_names = .{
        .ip_address_based_remote_info_list = "ipAddressBasedRemoteInfoList",
        .pipeline_info_list = "pipelineInfoList",
        .remote_source_code_analysis_server_info = "remoteSourceCodeAnalysisServerInfo",
        .vcenter_based_remote_info_list = "vcenterBasedRemoteInfoList",
        .version_control_info_list = "versionControlInfoList",
    };
};
