pub const Action = enum {
    clipboard_copy_from_local_device,
    clipboard_copy_to_local_device,
    file_upload,
    file_download,
    printing_to_local_device,
    domain_password_signin,
    domain_smart_card_signin,
    auto_time_zone_redirection,

    pub const json_field_names = .{
        .clipboard_copy_from_local_device = "CLIPBOARD_COPY_FROM_LOCAL_DEVICE",
        .clipboard_copy_to_local_device = "CLIPBOARD_COPY_TO_LOCAL_DEVICE",
        .file_upload = "FILE_UPLOAD",
        .file_download = "FILE_DOWNLOAD",
        .printing_to_local_device = "PRINTING_TO_LOCAL_DEVICE",
        .domain_password_signin = "DOMAIN_PASSWORD_SIGNIN",
        .domain_smart_card_signin = "DOMAIN_SMART_CARD_SIGNIN",
        .auto_time_zone_redirection = "AUTO_TIME_ZONE_REDIRECTION",
    };
};
