const aws = @import("aws");

const DirectoryConfigurationStatus = @import("directory_configuration_status.zig").DirectoryConfigurationStatus;

/// Contains information about the specified configurable setting for a
/// directory.
pub const SettingEntry = struct {
    /// The valid range of values for the directory setting. These values depend on
    /// the
    /// `DataType` of your directory.
    allowed_values: ?[]const u8,

    /// The value of the directory setting that is applied to the directory.
    applied_value: ?[]const u8,

    /// The data type of a directory setting. This is used to define the
    /// `AllowedValues` of a setting. For example a data type can be
    /// `Boolean`, `DurationInSeconds`, or `Enum`.
    data_type: ?[]const u8,

    /// The date and time when the request to update a directory setting was last
    /// submitted.
    last_requested_date_time: ?i64,

    /// The date and time when the directory setting was last updated.
    last_updated_date_time: ?i64,

    /// The name of the directory setting. For example:
    ///
    /// `TLS_1_0`
    name: ?[]const u8,

    /// Details about the status of the request to update the directory setting. If
    /// the directory
    /// setting is deployed in more than one region, status is returned for the
    /// request in each region
    /// where the setting is deployed.
    request_detailed_status: ?[]const aws.map.MapEntry(DirectoryConfigurationStatus),

    /// The value that was last requested for the directory setting.
    requested_value: ?[]const u8,

    /// The overall status of the request to update the directory setting request.
    /// If the
    /// directory setting is deployed in more than one region, and the request fails
    /// in any region,
    /// the overall status is `Failed`.
    request_status: ?DirectoryConfigurationStatus,

    /// The last status message for the directory status request.
    request_status_message: ?[]const u8,

    /// The type, or category, of a directory setting. Similar settings have the
    /// same type. For
    /// example, `Protocol`, `Cipher`, or `Certificate-Based
    /// Authentication`.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .allowed_values = "AllowedValues",
        .applied_value = "AppliedValue",
        .data_type = "DataType",
        .last_requested_date_time = "LastRequestedDateTime",
        .last_updated_date_time = "LastUpdatedDateTime",
        .name = "Name",
        .request_detailed_status = "RequestDetailedStatus",
        .requested_value = "RequestedValue",
        .request_status = "RequestStatus",
        .request_status_message = "RequestStatusMessage",
        .@"type" = "Type",
    };
};
