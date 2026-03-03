const std = @import("std");

pub const FailbackReplicationError = enum {
    agent_not_seen,
    failback_client_not_seen,
    not_converging,
    unstable_network,
    failed_to_establish_recovery_instance_communication,
    failed_to_download_replication_software_to_failback_client,
    failed_to_configure_replication_software,
    failed_to_pair_agent_with_replication_software,
    failed_to_establish_agent_replicator_software_communication,
    failed_getting_replication_state,
    snapshots_failure,
    failed_to_create_security_group,
    failed_to_launch_replication_server,
    failed_to_boot_replication_server,
    failed_to_authenticate_with_service,
    failed_to_download_replication_software,
    failed_to_create_staging_disks,
    failed_to_attach_staging_disks,
    failed_to_pair_replication_server_with_agent,
    failed_to_connect_agent_to_replication_server,
    failed_to_start_data_transfer,

    pub const json_field_names = .{
        .agent_not_seen = "AGENT_NOT_SEEN",
        .failback_client_not_seen = "FAILBACK_CLIENT_NOT_SEEN",
        .not_converging = "NOT_CONVERGING",
        .unstable_network = "UNSTABLE_NETWORK",
        .failed_to_establish_recovery_instance_communication = "FAILED_TO_ESTABLISH_RECOVERY_INSTANCE_COMMUNICATION",
        .failed_to_download_replication_software_to_failback_client = "FAILED_TO_DOWNLOAD_REPLICATION_SOFTWARE_TO_FAILBACK_CLIENT",
        .failed_to_configure_replication_software = "FAILED_TO_CONFIGURE_REPLICATION_SOFTWARE",
        .failed_to_pair_agent_with_replication_software = "FAILED_TO_PAIR_AGENT_WITH_REPLICATION_SOFTWARE",
        .failed_to_establish_agent_replicator_software_communication = "FAILED_TO_ESTABLISH_AGENT_REPLICATOR_SOFTWARE_COMMUNICATION",
        .failed_getting_replication_state = "FAILED_GETTING_REPLICATION_STATE",
        .snapshots_failure = "SNAPSHOTS_FAILURE",
        .failed_to_create_security_group = "FAILED_TO_CREATE_SECURITY_GROUP",
        .failed_to_launch_replication_server = "FAILED_TO_LAUNCH_REPLICATION_SERVER",
        .failed_to_boot_replication_server = "FAILED_TO_BOOT_REPLICATION_SERVER",
        .failed_to_authenticate_with_service = "FAILED_TO_AUTHENTICATE_WITH_SERVICE",
        .failed_to_download_replication_software = "FAILED_TO_DOWNLOAD_REPLICATION_SOFTWARE",
        .failed_to_create_staging_disks = "FAILED_TO_CREATE_STAGING_DISKS",
        .failed_to_attach_staging_disks = "FAILED_TO_ATTACH_STAGING_DISKS",
        .failed_to_pair_replication_server_with_agent = "FAILED_TO_PAIR_REPLICATION_SERVER_WITH_AGENT",
        .failed_to_connect_agent_to_replication_server = "FAILED_TO_CONNECT_AGENT_TO_REPLICATION_SERVER",
        .failed_to_start_data_transfer = "FAILED_TO_START_DATA_TRANSFER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .agent_not_seen => "AGENT_NOT_SEEN",
            .failback_client_not_seen => "FAILBACK_CLIENT_NOT_SEEN",
            .not_converging => "NOT_CONVERGING",
            .unstable_network => "UNSTABLE_NETWORK",
            .failed_to_establish_recovery_instance_communication => "FAILED_TO_ESTABLISH_RECOVERY_INSTANCE_COMMUNICATION",
            .failed_to_download_replication_software_to_failback_client => "FAILED_TO_DOWNLOAD_REPLICATION_SOFTWARE_TO_FAILBACK_CLIENT",
            .failed_to_configure_replication_software => "FAILED_TO_CONFIGURE_REPLICATION_SOFTWARE",
            .failed_to_pair_agent_with_replication_software => "FAILED_TO_PAIR_AGENT_WITH_REPLICATION_SOFTWARE",
            .failed_to_establish_agent_replicator_software_communication => "FAILED_TO_ESTABLISH_AGENT_REPLICATOR_SOFTWARE_COMMUNICATION",
            .failed_getting_replication_state => "FAILED_GETTING_REPLICATION_STATE",
            .snapshots_failure => "SNAPSHOTS_FAILURE",
            .failed_to_create_security_group => "FAILED_TO_CREATE_SECURITY_GROUP",
            .failed_to_launch_replication_server => "FAILED_TO_LAUNCH_REPLICATION_SERVER",
            .failed_to_boot_replication_server => "FAILED_TO_BOOT_REPLICATION_SERVER",
            .failed_to_authenticate_with_service => "FAILED_TO_AUTHENTICATE_WITH_SERVICE",
            .failed_to_download_replication_software => "FAILED_TO_DOWNLOAD_REPLICATION_SOFTWARE",
            .failed_to_create_staging_disks => "FAILED_TO_CREATE_STAGING_DISKS",
            .failed_to_attach_staging_disks => "FAILED_TO_ATTACH_STAGING_DISKS",
            .failed_to_pair_replication_server_with_agent => "FAILED_TO_PAIR_REPLICATION_SERVER_WITH_AGENT",
            .failed_to_connect_agent_to_replication_server => "FAILED_TO_CONNECT_AGENT_TO_REPLICATION_SERVER",
            .failed_to_start_data_transfer => "FAILED_TO_START_DATA_TRANSFER",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
