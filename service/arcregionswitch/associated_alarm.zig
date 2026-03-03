const AlarmType = @import("alarm_type.zig").AlarmType;

/// An Amazon CloudWatch alarm associated with a Region switch plan. These
/// alarms can be used to trigger automatic execution of the plan.
pub const AssociatedAlarm = struct {
    /// The alarm type for an associated alarm. An associated CloudWatch alarm can
    /// be an application health alarm or a trigger alarm.
    alarm_type: AlarmType,

    /// The cross account role for the configuration.
    cross_account_role: ?[]const u8 = null,

    /// The external ID (secret key) for the configuration.
    external_id: ?[]const u8 = null,

    /// The resource identifier for alarms that you associate with a plan.
    resource_identifier: []const u8,

    pub const json_field_names = .{
        .alarm_type = "alarmType",
        .cross_account_role = "crossAccountRole",
        .external_id = "externalId",
        .resource_identifier = "resourceIdentifier",
    };
};
