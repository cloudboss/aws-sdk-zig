/// An Auto Scaling group that is associated with an Amazon EKS managed node
/// group.
pub const AutoScalingGroup = struct {
    /// The name of the Auto Scaling group associated with an Amazon EKS managed
    /// node group.
    name: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
