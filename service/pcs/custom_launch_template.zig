/// An Amazon EC2 launch template PCS uses to launch compute nodes.
pub const CustomLaunchTemplate = struct {
    /// The ID of the EC2 launch template to use to provision instances.
    ///
    /// Example: `lt-xxxx`
    id: []const u8,

    /// The version of the EC2 launch template to use to provision instances.
    version: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .version = "version",
    };
};
