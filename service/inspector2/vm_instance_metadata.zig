const aws = @import("aws");

const VmPlatform = @import("vm_platform.zig").VmPlatform;

/// Contains metadata about a virtual machine (VM) instance associated with a
/// covered resource.
pub const VmInstanceMetadata = struct {
    /// The inventory hash of the VM instance.
    inventory_hash: ?[]const u8 = null,

    /// The platform of the VM instance.
    platform: ?VmPlatform = null,

    /// The tags associated with the VM instance.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The image reference of the VM instance.
    vm_image_reference: ?[]const u8 = null,

    pub const json_field_names = .{
        .inventory_hash = "inventoryHash",
        .platform = "platform",
        .tags = "tags",
        .vm_image_reference = "vmImageReference",
    };
};
