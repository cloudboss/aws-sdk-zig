const AWSServiceName = @import("aws_service_name.zig").AWSServiceName;

/// User-specified instances that must not be stopped. These instances will not
/// appear in the
/// list of instances that Amazon Web Services recommends to stop in order to
/// free up capacity.
pub const InstancesToExclude = struct {
    /// IDs of the accounts that own each instance that must not be stopped.
    account_ids: ?[]const []const u8 = null,

    /// List of user-specified instances that must not be stopped.
    instances: ?[]const []const u8 = null,

    /// Names of the services that own each instance that must not be stopped in
    /// order to free up
    /// the capacity needed to run the capacity task.
    services: ?[]const AWSServiceName = null,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .instances = "Instances",
        .services = "Services",
    };
};
