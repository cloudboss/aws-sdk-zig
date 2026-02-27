/// Information about a CloudWatch dashboard.
pub const CloudWatchDashboard = struct {
    /// The name of the CloudWatch dashboard.
    name: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
