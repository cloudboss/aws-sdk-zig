const AddOn = @import("add_on.zig").AddOn;
const AutoMountStatus = @import("auto_mount_status.zig").AutoMountStatus;
const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const ResourceType = @import("resource_type.zig").ResourceType;
const DiskState = @import("disk_state.zig").DiskState;
const Tag = @import("tag.zig").Tag;

/// Describes a block storage disk.
pub const Disk = struct {
    /// An array of objects representing the add-ons enabled on the disk.
    add_ons: ?[]const AddOn,

    /// The Amazon Resource Name (ARN) of the disk.
    arn: ?[]const u8,

    /// The resources to which the disk is attached.
    attached_to: ?[]const u8,

    /// (Discontinued) The attachment state of the disk.
    ///
    /// In releases prior to November 14, 2017, this parameter returned `attached`
    /// for system disks in the API response. It is now discontinued, but still
    /// included in the
    /// response. Use `isAttached` instead.
    attachment_state: ?[]const u8,

    /// The status of automatically mounting a storage disk to a virtual computer.
    ///
    /// This parameter only applies to Lightsail for Research resources.
    auto_mount_status: ?AutoMountStatus,

    /// The date when the disk was created.
    created_at: ?i64,

    /// (Discontinued) The number of GB in use by the disk.
    ///
    /// In releases prior to November 14, 2017, this parameter was not included in
    /// the API
    /// response. It is now discontinued.
    gb_in_use: ?i32,

    /// The input/output operations per second (IOPS) of the disk.
    iops: ?i32,

    /// A Boolean value indicating whether the disk is attached.
    is_attached: ?bool,

    /// A Boolean value indicating whether this disk is a system disk (has an
    /// operating system
    /// loaded on it).
    is_system_disk: ?bool,

    /// The AWS Region and Availability Zone where the disk is located.
    location: ?ResourceLocation,

    /// The unique name of the disk.
    name: ?[]const u8,

    /// The disk path.
    path: ?[]const u8,

    /// The Lightsail resource type (`Disk`).
    resource_type: ?ResourceType,

    /// The size of the disk in GB.
    size_in_gb: ?i32,

    /// Describes the status of the disk.
    state: ?DiskState,

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
        .add_ons = "addOns",
        .arn = "arn",
        .attached_to = "attachedTo",
        .attachment_state = "attachmentState",
        .auto_mount_status = "autoMountStatus",
        .created_at = "createdAt",
        .gb_in_use = "gbInUse",
        .iops = "iops",
        .is_attached = "isAttached",
        .is_system_disk = "isSystemDisk",
        .location = "location",
        .name = "name",
        .path = "path",
        .resource_type = "resourceType",
        .size_in_gb = "sizeInGb",
        .state = "state",
        .support_code = "supportCode",
        .tags = "tags",
    };
};
