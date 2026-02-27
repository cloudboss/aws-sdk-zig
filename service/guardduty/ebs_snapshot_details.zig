/// Contains details about the EBS snapshot that was scanned for malware.
pub const EbsSnapshotDetails = struct {
    /// The Amazon Resource Name (ARN) of the EBS snapshot.
    snapshot_arn: ?[]const u8,

    pub const json_field_names = .{
        .snapshot_arn = "SnapshotArn",
    };
};
