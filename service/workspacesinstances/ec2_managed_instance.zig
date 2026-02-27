/// Represents an EC2 instance managed by WorkSpaces.
pub const EC2ManagedInstance = struct {
    /// Unique identifier of the managed EC2 instance.
    instance_id: ?[]const u8,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
    };
};
