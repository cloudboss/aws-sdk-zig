pub const UrlType = enum {
    flink_dashboard_url,
    zeppelin_ui_url,

    pub const json_field_names = .{
        .flink_dashboard_url = "FLINK_DASHBOARD_URL",
        .zeppelin_ui_url = "ZEPPELIN_UI_URL",
    };
};
