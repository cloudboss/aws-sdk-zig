/// Import error data.
pub const ImportErrorData = struct {
    /// Import error data source account ID.
    account_id: ?[]const u8 = null,

    /// Import error data application ID.
    application_id: ?[]const u8 = null,

    /// Import error data ec2 LaunchTemplate ID.
    ec_2_launch_template_id: ?[]const u8 = null,

    /// Import error data raw error.
    raw_error: ?[]const u8 = null,

    /// Import error data row number.
    row_number: i64 = 0,

    /// Import error data source server ID.
    source_server_id: ?[]const u8 = null,

    /// Import error data wave id.
    wave_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountID",
        .application_id = "applicationID",
        .ec_2_launch_template_id = "ec2LaunchTemplateID",
        .raw_error = "rawError",
        .row_number = "rowNumber",
        .source_server_id = "sourceServerID",
        .wave_id = "waveID",
    };
};
