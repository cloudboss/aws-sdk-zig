const ResourceType = @import("resource_type.zig").ResourceType;

/// A definition of what is being billed for, including the type and amount.
pub const ResourceSpecification = struct {
    /// The amount of outbound bandwidth that is discounted in the offering.
    reserved_bitrate: ?i32 = null,

    /// The type of resource and the unit that is being billed for.
    resource_type: ResourceType,

    pub const json_field_names = .{
        .reserved_bitrate = "ReservedBitrate",
        .resource_type = "ResourceType",
    };
};
