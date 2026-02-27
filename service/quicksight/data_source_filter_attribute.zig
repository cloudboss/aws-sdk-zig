pub const DataSourceFilterAttribute = enum {
    direct_quicksight_viewer_or_owner,
    direct_quicksight_owner,
    direct_quicksight_sole_owner,
    datasource_name,

    pub const json_field_names = .{
        .direct_quicksight_viewer_or_owner = "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
        .direct_quicksight_owner = "DIRECT_QUICKSIGHT_OWNER",
        .direct_quicksight_sole_owner = "DIRECT_QUICKSIGHT_SOLE_OWNER",
        .datasource_name = "DATASOURCE_NAME",
    };
};
