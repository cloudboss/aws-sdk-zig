/// Provides information about a monitor in Deadline Cloud.
pub const MonitorSummary = struct {
    /// The UNIX timestamp of the date and time that the monitor was created.
    created_at: i64,

    /// The user name of the person that created the monitor.
    created_by: []const u8,

    /// The name of the monitor that displays on the Deadline Cloud console.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    display_name: []const u8,

    /// The Amazon Resource Name that the IAM Identity Center assigned to the
    /// monitor when it was created.
    identity_center_application_arn: []const u8,

    /// The Amazon Resource Name of the IAM Identity Center instance responsible for
    /// authenticating monitor users.
    identity_center_instance_arn: []const u8,

    /// The unique identifier for the monitor.
    monitor_id: []const u8,

    /// The Amazon Resource Name of the IAM role for the monitor. Users of the
    /// monitor use this role to access Deadline Cloud resources.
    role_arn: []const u8,

    /// The subdomain used for the monitor URL. The full URL of the monitor is
    /// subdomain.Region.deadlinecloud.amazonaws.com.
    subdomain: []const u8,

    /// The UNIX timestamp of the date and time that the monitor was last updated.
    updated_at: ?i64 = null,

    /// The user name of the person that last updated the monitor.
    updated_by: ?[]const u8 = null,

    /// The complete URL of the monitor. The full URL of the monitor is
    /// subdomain.Region.deadlinecloud.amazonaws.com.
    url: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .display_name = "displayName",
        .identity_center_application_arn = "identityCenterApplicationArn",
        .identity_center_instance_arn = "identityCenterInstanceArn",
        .monitor_id = "monitorId",
        .role_arn = "roleArn",
        .subdomain = "subdomain",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .url = "url",
    };
};
