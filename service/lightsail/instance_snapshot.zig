const Disk = @import("disk.zig").Disk;
const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const ResourceType = @import("resource_type.zig").ResourceType;
const InstanceSnapshotState = @import("instance_snapshot_state.zig").InstanceSnapshotState;
const Tag = @import("tag.zig").Tag;

/// Describes an instance snapshot.
pub const InstanceSnapshot = struct {
    /// The Amazon Resource Name (ARN) of the snapshot
    /// (`arn:aws:lightsail:us-east-2:123456789101:InstanceSnapshot/d23b5706-3322-4d83-81e5-12345EXAMPLE`).
    arn: ?[]const u8,

    /// The timestamp when the snapshot was created (`1479907467.024`).
    created_at: ?i64,

    /// An array of disk objects containing information about all block storage
    /// disks.
    from_attached_disks: ?[]const Disk,

    /// The blueprint ID from which you created the snapshot (`amazon_linux_2023`).
    /// A
    /// blueprint is a virtual private server (or *instance*) image used to create
    /// instances quickly.
    from_blueprint_id: ?[]const u8,

    /// The bundle ID from which you created the snapshot (`micro_x_x`).
    from_bundle_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the instance from which the snapshot was
    /// created
    /// (`arn:aws:lightsail:us-east-2:123456789101:Instance/64b8404c-ccb1-430b-8daf-12345EXAMPLE`).
    from_instance_arn: ?[]const u8,

    /// The instance from which the snapshot was created.
    from_instance_name: ?[]const u8,

    /// A Boolean value indicating whether the snapshot was created from an
    /// automatic
    /// snapshot.
    is_from_auto_snapshot: ?bool,

    /// The region name and Availability Zone where you created the snapshot.
    location: ?ResourceLocation,

    /// The name of the snapshot.
    name: ?[]const u8,

    /// The progress of the snapshot.
    ///
    /// This is populated only for disk snapshots, and is `null` for instance
    /// snapshots.
    progress: ?[]const u8,

    /// The type of resource (usually `InstanceSnapshot`).
    resource_type: ?ResourceType,

    /// The size in GB of the SSD.
    size_in_gb: ?i32,

    /// The state the snapshot is in.
    state: ?InstanceSnapshotState,

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
        .from_attached_disks = "fromAttachedDisks",
        .from_blueprint_id = "fromBlueprintId",
        .from_bundle_id = "fromBundleId",
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
