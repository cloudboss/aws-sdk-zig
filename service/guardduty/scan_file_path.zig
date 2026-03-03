/// Contains details of infected file including name, file path and hash.
pub const ScanFilePath = struct {
    /// File name of the infected file.
    file_name: ?[]const u8 = null,

    /// The file path of the infected file.
    file_path: ?[]const u8 = null,

    /// The hash value of the infected file.
    hash: ?[]const u8 = null,

    /// EBS volume ARN details of the infected file.
    volume_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_name = "FileName",
        .file_path = "FilePath",
        .hash = "Hash",
        .volume_arn = "VolumeArn",
    };
};
