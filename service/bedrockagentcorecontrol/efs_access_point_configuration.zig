/// Configuration for an Amazon EFS access point filesystem mounted into the
/// AgentCore Runtime. EFS access points provide shared file storage accessible
/// from your AgentCore Runtime sessions.
pub const EfsAccessPointConfiguration = struct {
    /// The ARN of the EFS access point to mount into the AgentCore Runtime.
    access_point_arn: []const u8,

    /// The mount path for the EFS access point inside the AgentCore Runtime. The
    /// path must be under `/mnt` with exactly one subdirectory level (for example,
    /// `/mnt/data`).
    mount_path: []const u8,

    pub const json_field_names = .{
        .access_point_arn = "accessPointArn",
        .mount_path = "mountPath",
    };
};
