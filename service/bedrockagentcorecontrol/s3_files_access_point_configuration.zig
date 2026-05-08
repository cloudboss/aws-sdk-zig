/// Configuration for an Amazon S3 Files access point filesystem mounted into
/// the AgentCore Runtime. S3 Files access points provide shared file storage
/// accessible from your AgentCore Runtime sessions.
pub const S3FilesAccessPointConfiguration = struct {
    /// The ARN of the S3 Files access point to mount into the AgentCore Runtime.
    access_point_arn: []const u8,

    /// The mount path for the S3 Files access point inside the AgentCore Runtime.
    /// The path must be under `/mnt` with exactly one subdirectory level (for
    /// example, `/mnt/data`).
    mount_path: []const u8,

    pub const json_field_names = .{
        .access_point_arn = "accessPointArn",
        .mount_path = "mountPath",
    };
};
