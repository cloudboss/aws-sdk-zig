pub const DataReplicationInitiationStepName = enum {
    wait,
    create_security_group,
    launch_replication_server,
    boot_replication_server,
    authenticate_with_service,
    download_replication_software,
    create_staging_disks,
    attach_staging_disks,
    pair_replication_server_with_agent,
    connect_agent_to_replication_server,
    start_data_transfer,

    pub const json_field_names = .{
        .wait = "WAIT",
        .create_security_group = "CREATE_SECURITY_GROUP",
        .launch_replication_server = "LAUNCH_REPLICATION_SERVER",
        .boot_replication_server = "BOOT_REPLICATION_SERVER",
        .authenticate_with_service = "AUTHENTICATE_WITH_SERVICE",
        .download_replication_software = "DOWNLOAD_REPLICATION_SOFTWARE",
        .create_staging_disks = "CREATE_STAGING_DISKS",
        .attach_staging_disks = "ATTACH_STAGING_DISKS",
        .pair_replication_server_with_agent = "PAIR_REPLICATION_SERVER_WITH_AGENT",
        .connect_agent_to_replication_server = "CONNECT_AGENT_TO_REPLICATION_SERVER",
        .start_data_transfer = "START_DATA_TRANSFER",
    };
};
