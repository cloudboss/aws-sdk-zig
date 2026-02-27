const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const ResourceType = @import("resource_type.zig").ResourceType;
const DiskSnapshotState = @import("disk_snapshot_state.zig").DiskSnapshotState;
const Tag = @import("tag.zig").Tag;

/// Describes a block storage disk snapshot.
pub const DiskSnapshot = struct {
    /// The Amazon Resource Name (ARN) of the disk snapshot.
    arn: ?[]const u8,

    /// The date when the disk snapshot was created.
    created_at: ?i64,

    /// The Amazon Resource Name (ARN) of the source disk from which the disk
    /// snapshot was
    /// created.
    from_disk_arn: ?[]const u8,

    /// The unique name of the source disk from which the disk snapshot was created.
    from_disk_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the source instance from which the disk
    /// (system volume)
    /// snapshot was created.
    from_instance_arn: ?[]const u8,

    /// The unique name of the source instance from which the disk (system volume)
    /// snapshot was
    /// created.
    from_instance_name: ?[]const u8,

    /// A Boolean value indicating whether the snapshot was created from an
    /// automatic
    /// snapshot.
    is_from_auto_snapshot: ?bool,

    /// The AWS Region and Availability Zone where the disk snapshot was created.
    location: ?ResourceLocation,

    /// The name of the disk snapshot (`my-disk-snapshot`).
    name: ?[]const u8,

    /// The progress of the snapshot.
    progress: ?[]const u8,

    /// The Lightsail resource type (`DiskSnapshot`).
    resource_type: ?ResourceType,

    /// The size of the disk in GB.
    size_in_gb: ?i32,

    /// The status of the disk snapshot operation.
    state: ?DiskSnapshotState,

    /// The support code. Include this code in your email to support when you have
    /// questions about
    /// an instance or another resource in Lightsail. This code enables our support
    /// team to look up
    /// your Lightsail information more easily.
    support_code: ?[]const u8,

    /// The tag keys and optional values for the resource. For more information
    /// about tags in
    /// Lightsail, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-tags).
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .from_disk_arn = "fromDiskArn",
        .from_disk_name = "fromDiskName",
        .from_instance_arn = "fromInstanceArn",
        .from_instance_name = "fromInstanceName",
        .is_from_auto_snapshot = "isFromAutoSnapshot",
        .location = "location",
        .name = "name",
        .progress = "progress",
        .resource_type = "resourceType",
        .size_in_gb = "sizeInGb",
        .state = "state",
        .support_code = "supportCode",
        .tags = "tags",
    };
};
