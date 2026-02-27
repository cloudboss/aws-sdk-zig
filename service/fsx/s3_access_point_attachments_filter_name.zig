pub const S3AccessPointAttachmentsFilterName = enum {
    file_system_id,
    volume_id,
    type,

    pub const json_field_names = .{
        .file_system_id = "FILE_SYSTEM_ID",
        .volume_id = "VOLUME_ID",
        .type = "TYPE",
    };
};
