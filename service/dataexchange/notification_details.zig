const DataUpdateRequestDetails = @import("data_update_request_details.zig").DataUpdateRequestDetails;
const DeprecationRequestDetails = @import("deprecation_request_details.zig").DeprecationRequestDetails;
const SchemaChangeRequestDetails = @import("schema_change_request_details.zig").SchemaChangeRequestDetails;

/// Extra details specific to this notification.
pub const NotificationDetails = struct {
    /// Extra
    /// details specific to a data update type notification.
    data_update: ?DataUpdateRequestDetails = null,

    /// Extra
    /// details specific to a deprecation type notification.
    deprecation: ?DeprecationRequestDetails = null,

    /// Extra
    /// details specific to a schema change type notification.
    schema_change: ?SchemaChangeRequestDetails = null,

    pub const json_field_names = .{
        .data_update = "DataUpdate",
        .deprecation = "Deprecation",
        .schema_change = "SchemaChange",
    };
};
