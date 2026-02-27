const FileSystemProtectionDescription = @import("file_system_protection_description.zig").FileSystemProtectionDescription;
const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;
const PerformanceMode = @import("performance_mode.zig").PerformanceMode;
const FileSystemSize = @import("file_system_size.zig").FileSystemSize;
const Tag = @import("tag.zig").Tag;
const ThroughputMode = @import("throughput_mode.zig").ThroughputMode;

/// A description of the file system.
pub const FileSystemDescription = struct {
    /// The unique and consistent identifier of the Availability Zone in which the
    /// file system is
    /// located, and is valid only for One Zone file systems. For example,
    /// `use1-az1` is an Availability Zone ID for the us-east-1 Amazon Web Services
    /// Region, and
    /// it has the same location in every Amazon Web Services account.
    availability_zone_id: ?[]const u8,

    /// Describes the Amazon Web Services Availability Zone in which the file system
    /// is located, and is
    /// valid only for One Zone file systems. For more information, see [Using EFS
    /// storage
    /// classes](https://docs.aws.amazon.com/efs/latest/ug/storage-classes.html) in
    /// the *Amazon EFS User Guide*.
    availability_zone_name: ?[]const u8,

    /// The time that the file system was created, in seconds (since
    /// 1970-01-01T00:00:00Z).
    creation_time: i64,

    /// The opaque string specified in the request.
    creation_token: []const u8,

    /// A Boolean value that, if true, indicates that the file system is encrypted.
    encrypted: ?bool,

    /// The Amazon Resource Name (ARN) for the EFS file system, in the
    /// format
    /// `arn:aws:elasticfilesystem:*region*:*account-id*:file-system/*file-system-id*
    /// `.
    /// Example with sample data:
    /// `arn:aws:elasticfilesystem:us-west-2:1111333322228888:file-system/fs-01234567`
    file_system_arn: ?[]const u8,

    /// The ID of the file system, assigned by Amazon EFS.
    file_system_id: []const u8,

    /// Describes the protection on the file system.
    file_system_protection: ?FileSystemProtectionDescription,

    /// The ID of an KMS key used to protect the encrypted file system.
    kms_key_id: ?[]const u8,

    /// The lifecycle phase of the file system.
    life_cycle_state: LifeCycleState,

    /// You can add tags to a file system, including a `Name` tag. For more
    /// information, see CreateFileSystem. If the file system has a `Name` tag,
    /// Amazon EFS returns
    /// the value in this field.
    name: ?[]const u8,

    /// The current number of mount targets that the file system has. For more
    /// information, see CreateMountTarget.
    number_of_mount_targets: i32 = 0,

    /// The Amazon Web Services account that created the file system.
    owner_id: []const u8,

    /// The performance mode of the file system.
    performance_mode: PerformanceMode,

    /// The amount of provisioned throughput, measured in MiBps, for the file
    /// system. Valid for
    /// file systems using `ThroughputMode` set to `provisioned`.
    provisioned_throughput_in_mibps: ?f64,

    /// The latest known metered size (in bytes) of data stored in the file system,
    /// in its
    /// `Value` field, and the time at which that size was determined in its
    /// `Timestamp` field. The `Timestamp` value is the integer number of
    /// seconds since 1970-01-01T00:00:00Z. The `SizeInBytes` value doesn't
    /// represent
    /// the size of a consistent snapshot of the file system, but it is eventually
    /// consistent when
    /// there are no writes to the file system. That is, `SizeInBytes` represents
    /// actual
    /// size only if the file system is not modified for a period longer than a
    /// couple of hours.
    /// Otherwise, the value is not the exact size that the file system was at any
    /// point in time.
    size_in_bytes: FileSystemSize,

    /// The tags associated with the file system, presented as an array of `Tag`
    /// objects.
    tags: []const Tag,

    /// Displays the file system's throughput mode. For more information, see
    /// [Throughput
    /// modes](https://docs.aws.amazon.com/efs/latest/ug/performance.html#throughput-modes)
    /// in the *Amazon EFS User Guide*.
    throughput_mode: ?ThroughputMode,

    pub const json_field_names = .{
        .availability_zone_id = "AvailabilityZoneId",
        .availability_zone_name = "AvailabilityZoneName",
        .creation_time = "CreationTime",
        .creation_token = "CreationToken",
        .encrypted = "Encrypted",
        .file_system_arn = "FileSystemArn",
        .file_system_id = "FileSystemId",
        .file_system_protection = "FileSystemProtection",
        .kms_key_id = "KmsKeyId",
        .life_cycle_state = "LifeCycleState",
        .name = "Name",
        .number_of_mount_targets = "NumberOfMountTargets",
        .owner_id = "OwnerId",
        .performance_mode = "PerformanceMode",
        .provisioned_throughput_in_mibps = "ProvisionedThroughputInMibps",
        .size_in_bytes = "SizeInBytes",
        .tags = "Tags",
        .throughput_mode = "ThroughputMode",
    };
};
