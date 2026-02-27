pub const OnClusterAppUIType = enum {
    spark_history_server,
    yarn_timeline_service,
    tez_ui,
    application_master,
    job_history_server,
    resource_manager,

    pub const json_field_names = .{
        .spark_history_server = "SparkHistoryServer",
        .yarn_timeline_service = "YarnTimelineService",
        .tez_ui = "TezUI",
        .application_master = "ApplicationMaster",
        .job_history_server = "JobHistoryServer",
        .resource_manager = "ResourceManager",
    };
};
