const TableRecordExpirationSettings = @import("table_record_expiration_settings.zig").TableRecordExpirationSettings;
const TableRecordExpirationStatus = @import("table_record_expiration_status.zig").TableRecordExpirationStatus;

/// The expiration configuration settings for records in a table, and the status
/// of the configuration. If the status of the configuration is enabled, records
/// expire and are automatically removed after the number of days specified in
/// the record expiration settings for the table.
pub const TableRecordExpirationConfigurationValue = struct {
    /// The expiration settings for records in the table.
    settings: ?TableRecordExpirationSettings = null,

    /// The status of the expiration settings for records in the table.
    status: ?TableRecordExpirationStatus = null,

    pub const json_field_names = .{
        .settings = "settings",
        .status = "status",
    };
};
