/// The Amazon Web Services resources in which DevOps Guru detected unusual
/// behavior that resulted in the
/// generation of an anomaly. When DevOps Guru detects multiple related
/// anomalies, it creates and
/// insight with details about the anomalous behavior and suggestions about how
/// to correct
/// the problem.
pub const AnomalyResource = struct {
    /// The name of the Amazon Web Services resource.
    name: ?[]const u8 = null,

    /// The type of the Amazon Web Services resource.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .@"type" = "Type",
    };
};
