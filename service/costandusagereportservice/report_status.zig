const LastStatus = @import("last_status.zig").LastStatus;

/// A two element dictionary with a `lastDelivery` and `lastStatus` key
/// whose values describe the date and status of the last delivered report for a
/// particular report
/// definition.
pub const ReportStatus = struct {
    /// A timestamp that gives the date of a report delivery.
    last_delivery: ?[]const u8,

    /// An enum that gives the status of a report delivery.
    last_status: ?LastStatus,

    pub const json_field_names = .{
        .last_delivery = "lastDelivery",
        .last_status = "lastStatus",
    };
};
