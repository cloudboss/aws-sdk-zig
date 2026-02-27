pub const FolderFilterAttribute = enum {
    parent_folder_arn,
    direct_quicksight_owner,
    direct_quicksight_sole_owner,
    direct_quicksight_viewer_or_owner,
    quicksight_owner,
    quicksight_viewer_or_owner,
    folder_name,

    pub const json_field_names = .{
        .parent_folder_arn = "PARENT_FOLDER_ARN",
        .direct_quicksight_owner = "DIRECT_QUICKSIGHT_OWNER",
        .direct_quicksight_sole_owner = "DIRECT_QUICKSIGHT_SOLE_OWNER",
        .direct_quicksight_viewer_or_owner = "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
        .quicksight_owner = "QUICKSIGHT_OWNER",
        .quicksight_viewer_or_owner = "QUICKSIGHT_VIEWER_OR_OWNER",
        .folder_name = "FOLDER_NAME",
    };
};
