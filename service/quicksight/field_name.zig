pub const FieldName = enum {
    flow_name,
    flow_description,
    direct_quicksight_owner,
    direct_quicksight_viewer_or_owner,
    direct_quicksight_sole_owner,

    pub const json_field_names = .{
        .flow_name = "FLOW_NAME",
        .flow_description = "FLOW_DESCRIPTION",
        .direct_quicksight_owner = "DIRECT_QUICKSIGHT_OWNER",
        .direct_quicksight_viewer_or_owner = "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
        .direct_quicksight_sole_owner = "DIRECT_QUICKSIGHT_SOLE_OWNER",
    };
};
