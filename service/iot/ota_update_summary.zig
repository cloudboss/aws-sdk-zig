/// An OTA update summary.
pub const OTAUpdateSummary = struct {
    /// The date when the OTA update was created.
    creation_date: ?i64,

    /// The OTA update ARN.
    ota_update_arn: ?[]const u8,

    /// The OTA update ID.
    ota_update_id: ?[]const u8,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .ota_update_arn = "otaUpdateArn",
        .ota_update_id = "otaUpdateId",
    };
};
